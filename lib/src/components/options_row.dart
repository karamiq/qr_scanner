import 'dart:io';
// Add this import for Uint8List

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../common_lib.dart';
import '../../data/models/qr_data_model.dart';
import 'qr_icon_option.dart';

class OptionsRow extends StatelessWidget {
  const OptionsRow({
    super.key,
    required this.item,
    required this.screenshotController,
  });

  final QrDataModel item;
  final ScreenshotController screenshotController;

  Future<void> saveToGallery() async {
    Uint8List? uint8list = await screenshotController.capture();
    if (uint8list != null) {
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        String picturesName = "${item.type}-${item.id}.png";

        await SaverGallery.saveImage(
          Uint8List.fromList(uint8list),
          quality: 60,
          fileName: picturesName,
          skipIfExists: false,
        );
      } else {
        Utils.showErrorSnackBar('Permission not granted');
      }
      Utils.showSuccessSnackBar('Image saved to gallery');
    } else {
      Utils.showErrorSnackBar('Failed to save image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RowPadded(
      gap: Insets.extraLarge,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QRIconOption(
          icon: Icons.share,
          text: 'Share',
          onPressed: () async {
            // Capture the screenshot
            Uint8List? uint8list = await screenshotController.capture();
            if (uint8list != null) {
              // Get the temporary directory
              final directory = await getTemporaryDirectory();
              final path = '${directory.path}/${item.type}-${item.id}.png';

              // Save the captured image to the temporary directory
              final file = File(path);
              await file.writeAsBytes(uint8list);
              // Create an XFile from the saved file
              final xFile = XFile(file.path);
              // Share the image file
              await Share.shareXFiles(
                [xFile],
              );
            } else {
              Utils.showErrorSnackBar('Failed to capture screenshot');
            }
          },
        ),
        QRIconOption(
          icon: Icons.file_copy,
          text: 'Copy',
          onPressed: () {
            // Copy the URL
            Clipboard.setData(ClipboardData(text: item.data));
          },
        ),
        QRIconOption(
          icon: Icons.save,
          text: 'Save',
          onPressed: saveToGallery,
        ),
      ],
    );
  }
}
