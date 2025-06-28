import 'package:app/data/models/qr_data_model.dart';
import 'package:app/data/models/qr_type_enum.dart';
import 'package:app/utils/components/custom_app_bar.dart';
import 'package:app/utils/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../components/options_row.dart';
import 'components/detailse_list-tile.dart';
import 'components/qr-code-image.dart';
import '../../../common_lib.dart';
import '../../../theme/app_colors.dart';

class QrCodeDetailes extends HookWidget {
  const QrCodeDetailes({
    super.key,
    required this.item,
  });

  final QrDataModel item;

  @override
  Widget build(BuildContext context) {
    final ScreenshotController screenshotController = ScreenshotController();
    useState<bool>(false);

    Widget buildActionButton() {
      dynamic button(text) => FilledButton(
          onPressed: () async {
            await launchApp(item.data);
          },
          child: Text(text));

      switch (handleQRCode(item.data)) {
        case QRType.network:
          return button('Connect');
        case QRType.event:
          return button('Add to events');
        case QRType.website:
        case QRType.whatsApp:
        case QRType.twitter:
        case QRType.email:
        case QRType.instagram:
        case QRType.phoneNumber:
        case QRType.location:
          return button('Open');
        case QRType.contact:
        case QRType.business:
          return button('Add to Contacts');
        case QRType.text:
          return Container();
      }
    }

    return CustomScaffold(
      floatingActionButton: handleQRCode(item.data) != QRType.text ? buildActionButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: ColumnPadded(
          gap: Insets.medium,
          children: [
            const CustomAppBar(title: 'Result'),
            ScreenshotQRImage(screenshotController: screenshotController, item: item),
            const Gap(
              Insets.medium,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              padding: Insets.smallAll,
              decoration: const BoxDecoration(
                borderRadius: BorderSize.extraSmallRadius,
                color: AppColors.surface,
              ),
              child: ColumnPadded(
                gap: Insets.extraSmall,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailesListTile(item: item),
                  const Divider(
                    color: AppColors.textMuted,
                    thickness: .3,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Insets.small, vertical: Insets.extraSmall),
                    child: Text(
                      item.data,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                      ),
                      softWrap: true,
                    ),
                  ),
                  const Gap(Insets.medium),
                ],
              ),
            ),
            OptionsRow(
              item: item,
              screenshotController: screenshotController,
            ),
            const Gap(Insets.large * 3),
          ],
        ),
      ),
    );
  }
}
