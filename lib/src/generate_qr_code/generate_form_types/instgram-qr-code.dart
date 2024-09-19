import 'package:flutter/material.dart';
import '../../../common_lib.dart';
import '../../../data/models/qr_type_enum.dart';

class GenerateInstagramQRCode extends HookWidget {
  const GenerateInstagramQRCode({
    super.key,
    required this.type,
    required this.onChange,
  });

  final QRType type;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final numberController = useTextEditingController();
    void updateQRData() {
      String qrData = '''https://instagram.com/${numberController.text}

''';

      onChange(qrData);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: ColumnPadded(
        gap: Insets.medium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Username'),
          CustomTextFormField(
            controller: numberController,
            hintText: 'Enter instagram username',
            validator: context.validator.required().build(),
            onChanged: (value) => updateQRData(),
          ),
        ],
      ),
    );
  }
}
