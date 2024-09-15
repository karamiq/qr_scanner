import 'dart:ui';
import 'package:app/common_lib.dart';
import 'package:app/data/models/qr_data_model.dart';
import 'package:app/data/models/qr_type_enum.dart';
import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/src/components/scan_button.dart';
import 'package:app/src/settings/settings_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import '../components/custom_bottom_navigation_bar.dart';
import '../generate/generate_page.dart';
import '../history/history_page.dart';
import 'components/scan_spot.dart';

class CameraPage extends HookConsumerWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AudioPlayer audioPlayer = AudioPlayer();
    final isFlashOn = useState<bool>(false);
    final zoomLevel = useState<double>(0.0);
    final showResult = useState<bool>(true);
    final isFrontCamera = useState<bool>(false);
    final pageIndex = ref.watch(currentPageIndexProvider);
    final cameraController = MobileScannerController();
    String? url;

    useEffect(() {
      return () {
        cameraController.dispose();
      };
    }, [cameraController]);

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
            id: const Uuid().v4(),
            data: url!,
            date: DateTime.now(),
            type: handleQRCode(url!).toString());
        final state = await ref.read(addQRDataProvider.notifier).addQRdata(item);

        state.isLoading;

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
        // Prevent flash toggle if camera is flipped
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
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, pageConstraints) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            MobileScanner(
              errorBuilder: (context, error, child) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(error.toString()),
                    ElevatedButton(
                        onPressed: () async {
                          await cameraController.stop();
                          await cameraController.start();
                        },
                        child: const Text('Try again')),
                    Container(
                      color: Colors.red,
                      height: 250,
                      width: 250,
                      child: child,
                    )
                  ],
                ),
              ),
              overlayBuilder: (context, constraints) => pageIndex == 1
                  ? SafeArea(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: Insets.medium, vertical: Insets.small),
                            decoration: const BoxDecoration(
                                color: Color(0xFF333333),
                                borderRadius: BorderSize.extraSmallRadius),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: selectImageFromGallery,
                                  icon: const Icon(
                                    Icons.photo_library,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                IconButton(
                                  onPressed: toggleFlash,
                                  icon: Icon(
                                    isFlashOn.value ? Icons.flash_on : Icons.flash_off,
                                    color: isFlashOn.value
                                        ? const Color(0xFFFFC107)
                                        : const Color(0xFFD9D9D9),
                                  ),
                                ),
                                IconButton(
                                  onPressed: flipCamera,
                                  icon: Icon(
                                    Icons.flip_camera_android,
                                    color: isFrontCamera.value
                                        ? const Color(0xFFD9D9D9)
                                        : const Color(0xFFFFC107),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(120),
                          const ScanSpot(),
                          Gap(pageConstraints.maxHeight / 3),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    zoomLevel.value =
                                        (zoomLevel.value - 0.1).clamp(0.0, 1.0);
                                    cameraController.setZoomScale(zoomLevel.value);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: zoomLevel.value,
                                    min: 0.0,
                                    max: 1.0,
                                    divisions: 10,
                                    label: '${(zoomLevel.value * 100).round()}% zoom',
                                    thumbColor: const Color(0xFFFDB623),
                                    activeColor: const Color(0xFFFDB623),
                                    inactiveColor: Colors.white,
                                    onChanged: (newZoom) {
                                      zoomLevel.value = newZoom;
                                      cameraController.setZoomScale(zoomLevel.value);
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    zoomLevel.value =
                                        (zoomLevel.value + 0.1).clamp(0.0, 1.0);
                                    cameraController.setZoomScale(zoomLevel.value);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              controller: cameraController,
              scanWindow: Rect.fromCircle(
                center:
                    Offset(pageConstraints.maxWidth / 2, pageConstraints.maxHeight / 2.4),
                radius: 125,
              ),
              onDetect: (capture) => captureCode(capture),
            ),
            if (pageIndex != 1)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            const GeneratePage(),
            HistoryPage(),
            const CustomBottomNavigationBar(),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ScanButton(),
    );
  }
}
