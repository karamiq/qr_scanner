import 'package:flutter/material.dart';
import '../../../common_lib.dart';
import '../../../data/models/qr_type_enum.dart';

class GenerateEmailORXQRCode extends HookWidget {
  const GenerateEmailORXQRCode({
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
      String qrData = '''mailto:${numberController.text}

''';

      onChange(qrData);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: ColumnPadded(
        gap: Insets.medium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email'),
          CustomTextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: numberController,
            hintText: 'Enter email',
            validator: context.validator.email().build(),
            onChanged: (value) => updateQRData(),
          ),
        ],
      ),
    );
  }
}
