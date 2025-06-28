import 'package:flutter/material.dart';
import '../../../common_lib.dart';
import '../../../data/models/qr_type_enum.dart';

class GeneratePhoneNumberQRCode extends HookWidget {
  const GeneratePhoneNumberQRCode({
    super.key,
    required this.type,
    required this.onChange,
  });

  final QRType type;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final numberController = useTextEditingController(text: '+964');
    void updateQRData() {
      String qrData = '''tel:${numberController.text}

''';

      onChange(qrData);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: ColumnPadded(
        gap: Insets.medium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Phone Number'),
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            controller: numberController,
            hintText: '+964xxxxxxxxxx',
            validator: context.validator.phone().build(),
            onChanged: (value) => updateQRData(),
          ),
        ],
      ),
    );
  }
}
