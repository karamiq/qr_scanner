import 'dart:ui';

import 'package:app/common_lib.dart';
import 'package:app/data/models/qr_data_model.dart';
import 'package:app/data/models/qr_type_enum.dart';
import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/src/components/scan_button.dart';
import 'package:app/src/settings/settings_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

import '../components/custom_bottom_navigation_bar.dart';
import '../generate/generate_page.dart';
import '../history/history_page.dart';
import 'components/scan_spot.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage>
    with SingleTickerProviderStateMixin {
  int get pageIndex => ref.watch(currentPageIndexProvider);
  late TabController _tabController;
  late MobileScannerController cameraController;
  final _audioPlayer = AudioPlayer();
  dynamic previewData;
  String? url;
  double zoomLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    cameraController = MobileScannerController();
  }

  @override
  void dispose() {
    cameraController.dispose();
    _tabController.dispose();
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cameraController.start();
  }

  void captureCode(capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    url = barcodes.first.rawValue;
    if (barcodes.isNotEmpty && ref.watch(currentPageIndexProvider) == 1) {
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
        setState(() {
          cameraController.start();
        });
      });

      if (await ref.watch(getBeepProvider.future)) {
        _audioPlayer.play(AssetSource('sounds/short-beep-tone.mp3'));
      }

      if (await ref.watch(getVibrationProvider.future)) {
        Vibration.vibrate(amplitude: 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, pageConstraints) {
        return Stack(
          children: [
            Container(
              color: const Color(0xFF333333).withOpacity(.8),
            ),
            MobileScanner(
              overlayBuilder: (context, constraints) => pageIndex == 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const ScanSpot(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => setState(() {
                                  zoomLevel = (zoomLevel - 0.1).clamp(0.0, 1.0);
                                  cameraController.setZoomScale(zoomLevel);
                                }),
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Slider(
                                  value: zoomLevel,
                                  min: 0.0,
                                  max: 1.0,
                                  divisions: 10,
                                  label: '${(zoomLevel * 100).round()}% zoom',
                                  thumbColor: const Color(0xFFFDB623),
                                  activeColor: const Color(0xFFFDB623),
                                  inactiveColor: Colors.white,
                                  onChanged: (newZoom) {
                                    setState(() {
                                      zoomLevel = newZoom;
                                      cameraController.setZoomScale(zoomLevel);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () => setState(() {
                                  zoomLevel = (zoomLevel + 0.1).clamp(0.0, 1.0);
                                  cameraController.setZoomScale(zoomLevel);
                                }),
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              controller: cameraController,
              scanWindow: Rect.fromCircle(
                center:
                    Offset(pageConstraints.maxWidth / 2, pageConstraints.maxHeight / 3),
                radius: 125,
              ),
              onDetect: captureCode,
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
            HistoryPage(
              tabController: _tabController,
            ),
            const CustomBottomNavigationBar(),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ScanButton(),
    );
  }
}
