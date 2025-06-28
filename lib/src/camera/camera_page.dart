import 'dart:ui';
import 'package:app/common_lib.dart';
import 'package:app/data/models/qr_data_model.dart';
import 'package:app/data/models/qr_type_enum.dart';
import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/src/components/scan_button.dart';
import 'package:app/src/settings/settings_page.dart';
import 'package:app/utils/components/custom_scaffold.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restart_app/restart_app.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../generate/generate_page.dart';
import '../history/history_page.dart';
import 'components/cam_top_options.dart';
import 'components/scan_spot.dart';
import '../../theme/app_colors.dart';

class CameraPage extends StatefulHookConsumerWidget {
  const CameraPage({super.key});

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  late MobileScannerController cameraController;
  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    final isFlashOn = useState<bool>(false);
    final zoomLevel = useState<double>(0.0);
    final showResult = useState<bool>(true);
    final isFrontCamera = useState<bool>(false);
    final pageIndex = ref.watch(currentPageIndexProvider);

    String? url;

    void captureCode(BarcodeCapture? capture) async {
      if (capture == null) {
        Utils.showErrorSnackBar('Faild to detect QR Code in the image');
        return;
      }
      final List<Barcode> barcodes = capture.barcodes;
      url = barcodes.first.rawValue;
      if (barcodes.isNotEmpty && pageIndex == 1 && showResult.value == true) {
        showResult.value = false;
        final item = QrDataModel(
            id: const Uuid().v4(), data: url!, date: DateTime.now(), type: handleQRCode(url!).toString());
        // ignore: unused_result
        await ref.read(addQRDataProvider.notifier).addQRdata(item);

        context
            .push(
          RoutesDocument.qrDetails(item.id),
          extra: item,
        )
            .then((_) {
          showResult.value = true;
        });
        if (await ref.watch(getBeepProvider.future)) {
          audioPlayer.play(AssetSource('sounds/short-beep-tone.mp3'));
        }
        if (await ref.watch(getVibrationProvider.future)) {
          Vibration.vibrate(amplitude: 1, duration: 100);
        }
      }
    }

    void selectImageFromGallery() async {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          final capture = await cameraController.analyzeImage(image.path);
          captureCode(capture);
        }
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }

    void toggleFlash() async {
      if (isFrontCamera.value) {
        Utils.showNotificatonSnackBar('Flash cannot be turned on while the front camera is active.');
        return;
      }
      if (isFlashOn.value) {
        await cameraController.toggleTorch();
        isFlashOn.value = false;
      } else {
        await cameraController.toggleTorch();
        isFlashOn.value = true;
      }
    }

    void flipCamera() async {
      await cameraController.switchCamera();
      isFrontCamera.value = !isFrontCamera.value;
      isFlashOn.value = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: LayoutBuilder(builder: (context, pageConstraints) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            MobileScanner(
              errorBuilder: (context, error, child) => Center(
                child: CustomScaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Error while initializing the camera \nplease restart the application',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        const Gap(20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderSize.extraSmallRadius,
                              ),
                              backgroundColor: AppColors.background,
                            ),
                            onPressed: () async {
                              await Permission.notification.request();
                              await Restart.restartApp(
                                notificationTitle: 'Restarting App',
                                notificationBody: 'Please tap here to open the app again.',
                              );
                            },
                            child: const Padding(
                              padding: Insets.smallAll,
                              child: Text(
                                'Restart',
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              overlayBuilder: (context, constraints) => pageIndex == 1
                  ? SafeArea(
                      child: Column(
                        children: [
                          CamTopOptions(
                              flipCamera: flipCamera,
                              selectImageFromGallery: selectImageFromGallery,
                              toggleFlash: toggleFlash,
                              isFlashOn: isFlashOn,
                              isFrontCamera: isFrontCamera),
                          Gap(pageConstraints.maxHeight * .07),
                          const ScanSpot(),
                          Gap(pageConstraints.maxHeight * .07),
                          ZoomSlider(zoomLevel: zoomLevel, cameraController: cameraController),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              controller: cameraController,
              scanWindow: Rect.fromCircle(
                center: Offset(pageConstraints.maxWidth / 2, pageConstraints.maxHeight / 2.4),
                radius: 125,
              ),
              onDetect: (capture) => captureCode(capture),
            ),
            if (pageIndex != 1)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: AppColors.transparent,
                  ),
                ),
              ),
            const HistoryPage(),
            const GeneratePage(),
            const CustomBottomNavigationBar(),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ScanButton(),
    );
  }
}

class ZoomSlider extends StatelessWidget {
  const ZoomSlider({
    super.key,
    required this.zoomLevel,
    required this.cameraController,
  });

  final ValueNotifier<double> zoomLevel;
  final MobileScannerController cameraController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              zoomLevel.value = (zoomLevel.value - 0.1).clamp(0.0, 1.0);
              cameraController.setZoomScale(zoomLevel.value);
            },
            icon: const Icon(
              Icons.remove,
              color: AppColors.textWhite,
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                valueIndicatorTextStyle: const TextStyle(
                  color: AppColors.textWhite,
                ),
              ),
              child: Slider(
                value: zoomLevel.value,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${(zoomLevel.value * 100).round()}%',
                thumbColor: AppColors.primary,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.textWhite,
                onChanged: (newZoom) {
                  zoomLevel.value = newZoom;
                  cameraController.setZoomScale(zoomLevel.value);
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              zoomLevel.value = (zoomLevel.value + 0.1).clamp(0.0, 1.0);
              cameraController.setZoomScale(zoomLevel.value);
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}
