import 'package:app/src/components/custom_bottom_navigation_bar.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../common_lib.dart';
import '../../../data/models/qr_data_model.dart';
import '../../../data/models/qr_type_enum.dart';
import '../../../data/providers/qr_data_provider.dart';

class CreatePage extends HookConsumerWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    int pageIndex = ref.watch(currentPageIndexProvider);
    final focusNode = useMemoized(() => FocusNode());
    final formKey = useMemoized(() => GlobalKey<FormState>());

    useEffect(() {
      if (pageIndex != 2) {
        formKey.currentState?.reset();
        textController.clear();
      }
      return null;
    }, [pageIndex]);

    return FormBody(formKey: formKey, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFFDB623),
            borderRadius: BorderSize.extraSmallRadius,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
            decoration: const BoxDecoration(
              color: Color(0xFF3B3B3B),
              borderRadius: BorderSize.extraSmallRadius,
            ),
            child: Column(
              children: [
                const Gap(Insets.large),
                Image.asset(
                  Assets.assetsImagesAppIconLight,
                  height: 90,
                ),
                const Gap(Insets.extraLarge),
                TextFormField(
                  controller: textController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(hintText: 'Enter data'),
                  validator: context.validator.required().build(),
                ),
                const Gap(Insets.medium),
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: -2)
                  ]),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        DelightToastBar(
                          autoDismiss: true,
                          position: DelightSnackbarPosition.top,
                          snackbarDuration: const Duration(milliseconds: 1700),
                          builder: (context) => Container(
                            padding: Insets.mediumAll,
                            margin: Insets.smallAll,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B3B3B),
                              borderRadius: BorderSize.extraSmallRadius,
                            ),
                            child: const Text(
                              "The contact has been added to history list successfully",
                              style: TextStyle(
                                color: Color(0xFFFDB623),
                              ),
                            ),
                          ),
                        ).show(context);
                        focusNode.unfocus();
                        ref.read(addQRDataProvider.notifier).addQRdata(QrDataModel(
                            id: const Uuid().v4(),
                            data: textController.text,
                            date: DateTime.now(),
                            type: handleQRCode(textController.text).name));

                        textController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDB623),
                      foregroundColor: const Color(0xFF333333),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderSize.extraSmallRadius,
                      ),
                    ),
                    child: const Text('Add to history'),
                  ),
                ),
                const Gap(Insets.large),
              ],
            ),
          ),
        ),
      ),
      Gap(MediaQuery.of(context).size.height / 8),
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFFDB623),
          borderRadius: BorderSize.extraSmallRadius,
        ),
        child: Container(
          padding: Insets.smallAll,
          decoration: const BoxDecoration(
            color: Color(0xFF3B3B3B),
            borderRadius: BorderSize.extraSmallRadius,
          ),
          child: const Text(
            'Note: the type of the added  QR code data will be automatically detected.',
            style: TextStyle(
              color: Color(0xFFA4A4A4),
            ),
          ),
        ),
      ),
      const Gap(Insets.medium),
    ]);
  }
}
