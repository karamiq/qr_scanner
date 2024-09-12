import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../common_lib.dart';
import '../../data/models/qr_data_model.dart';
import 'options_row.dart';

Future<dynamic> showQrdataDialog(
    BuildContext context, ScreenshotController screenshotController, QrDataModel item) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF3B3B3B),
      content: SizedBox(
        height: 250,
        width: 250,
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderSize.extraSmallRadius,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFFDB623), width: 4),
            ),
            child: QrImageView(
              gapless: false,
              dataModuleStyle:
                  const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square),
              foregroundColor: Colors.black,
              data: item.data,
              version: QrVersions.auto,
            ),
          ),
        ),
      ),
      actions: [OptionsRow(item: item, screenshotController: screenshotController)],
    ),
  );
}
