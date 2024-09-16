import 'package:app/data/models/qr_data_model.dart';
import 'package:app/data/models/qr_type_enum.dart';
import 'package:app/utils/components/custom_app_bar.dart';
import 'package:app/utils/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common_lib.dart';
import '../components/options_row.dart';
import 'components/detailse_list-tile.dart';
import 'components/qr-code-image.dart';

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
                            !isExpanded.value
                                ? '${item.data.split('\n').first}...'
                                : '',
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
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            isLoading.value = true;
                            await launchApp(item.data);
                            isLoading.value = false;
                          },
                    child: isLoading.value
                        ? const CircularProgressIndicator.adaptive()
                        : const Text('Open'),
                  ),
                )
              ],
            ),
          ),
          const Gap(Insets.extraSmall),
          OptionsRow(
            item: item,
            screenshotController: screenshotController,
          ),
        ],
      ),
    ));
  }
}
