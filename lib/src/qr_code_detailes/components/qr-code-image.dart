import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../common_lib.dart';
import '../../../data/models/qr_data_model.dart';

class ScreenshotQRImage extends StatelessWidget {
  const ScreenshotQRImage({
    super.key,
    required this.screenshotController,
    required this.item,
  });

  final ScreenshotController screenshotController;
  final QrDataModel item;

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderSize.extraSmallRadius,
            border: Border.all(color: const Color(0xFFFDB623), width: 4)),
        child: QrImageView(
          gapless: false,
          dataModuleStyle:
              const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square),
          // ignore: deprecated_member_use
          foregroundColor: Colors.black,
          data: item.data,
          version: QrVersions.auto,
        ),
      ),
    );
  }
}