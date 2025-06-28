import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../../../common_lib.dart';
import '../../../data/models/qr_data_model.dart';
import '../../../theme/app_colors.dart';

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
            color: AppColors.textWhite,
            borderRadius: BorderSize.extraSmallRadius,
            border: Border.all(color: AppColors.primary, width: 4)),
        child: QrImageView(
          gapless: false,
          dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square),
          // ignore: deprecated_member_use
          foregroundColor: AppColors.textDefault,
          data: item.data,
          version: QrVersions.auto,
        ),
      ),
    );
  }
}

class LegoQRPainter extends QrPainter {
  LegoQRPainter.withQr({required super.qr}) : super.withQr();
}
