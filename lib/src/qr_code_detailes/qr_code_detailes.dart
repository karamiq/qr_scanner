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

class QrCodeDetailes extends HookWidget {
  const QrCodeDetailes({
    super.key,
    required this.item,
  });
  final QrDataModel item;

  @override
  Widget build(BuildContext context) {
    final ScreenshotController screenshotController = ScreenshotController();
    ValueNotifier<bool> isLoading = useState<bool>(false);
    ValueNotifier<bool> isExpanded = useState<bool>(false);
    Widget handleActionButton() {
      dynamic button(text) => Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () async {
                  await launchApp(item.data);
                },
                child: Text(text)),
          );
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
        default:
          return Container();
      }
    }

    return CustomScaffold(
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
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: Insets.smallAll,
            decoration: const BoxDecoration(
              borderRadius: BorderSize.extraSmallRadius,
              color: Color(0xFF3C3C3C),
            ),
            child: ColumnPadded(
              gap: Insets.extraSmall,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailesListTile(item: item),
                const Divider(
                  color: Color(0xFF858585),
                  thickness: .3,
                  endIndent: 10,
                  indent: 10,
                ),
                ExpansionPanelList(
                  elevation: 0,
                  dividerColor: Colors.yellow,
                  expansionCallback: (panelIndex, isExpandedd) =>
                      isExpanded.value = !isExpanded.value,
                  children: [
                    ExpansionPanel(
                      backgroundColor: const Color(0xFF3C3C3C),
                      isExpanded: isExpanded.value,
                      headerBuilder: (context, isExpandedd) => AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            !isExpanded.value ? '${item.data.split('\n').first}...' : '',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      body: Text(
                        item.data,
                        style: const TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 17,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ],
                ),
                handleActionButton(),
              ],
            ),
          ),
          const Gap(Insets.extraSmall),
          OptionsRow(
            item: item,
            screenshotController: screenshotController,
          ),
          const Gap(Insets.extraSmall),
        ],
      ),
    ));
  }
}
