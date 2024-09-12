import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
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
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final result =
            await ImageGallerySaver.saveImage(uint8list, name: '${item.type}-qr-code');
        if (result != null && result["isSuccess"]) {
          Utils.showSuccessSnackBar('Image saved successfully');
        } else {
          Utils.showErrorSnackBar('Failed to save image');
        }
      } else {
        Utils.showErrorSnackBar('Permission not granted');
      }
    } else {}
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
          onPressed: () {
            //Share the qr code with others
            Share.share(item.data);
          },
        ),
        QRIconOption(
          icon: Icons.file_copy,
          text: 'Copy',
          onPressed: () {
            //copy the url
            Clipboard.setData(ClipboardData(text: item.data));
            Utils.showSuccessSnackBar('Copied');
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
