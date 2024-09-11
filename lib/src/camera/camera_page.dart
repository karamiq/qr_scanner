import 'dart:ui';

import 'package:app/common_lib.dart';
import 'package:app/data/models/qr_data_model.dart';
import 'package:app/data/models/qr_type_enum.dart';
import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/src/components/scan_button.dart';
import 'package:app/src/settings/settings_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
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
  bool isDialogShowing = false;
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

  void captureCode(capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    url = barcodes.first.rawValue;
    if (barcodes.isNotEmpty &&
        !isDialogShowing &&
        ref.watch(currentPageIndexProvider) == 1) {
      setState(() => isDialogShowing = true);
      final state = await ref.read(addQRDataProvider.notifier).addQRdata(QrDataModel(
          id: const Uuid().v4(),
          data: url!,
          date: DateTime.now(),
          type: handleQRCode(url!).toString()));

      state.isLoading;

      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 37, 37, 37),
              contentPadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                TextButton(
                    onPressed: () async => await launchUrl(Uri.parse(url!)),
                    child: const Text(
                      'Open',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
                TextButton(
                    onPressed: () => context.pop(),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.blueAccent),
                    ))
              ],
              content: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 210,
                  child: Card(
                    child: LinkPreview(
                      enableAnimation: true,
                      onLinkPressed: (url) async => await launchUrl(Uri.parse(url)),
                      onPreviewDataFetched: (data) {
                        setState(() => previewData = data);
                      },
                      previewData: previewData,
                      text: barcodes.first.rawValue ?? "",
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ).then((_) {
        setState(() {
          isDialogShowing = false;
        });
      });
      if (await ref.watch(getBeepProvider.future)) {
        _audioPlayer.play(AssetSource('sounds/short-beep-tone.mp3'));
      }

      if (await ref.watch(getVibrationProvider.future)) {
        Vibration.vibrate(amplitude: -20);
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
