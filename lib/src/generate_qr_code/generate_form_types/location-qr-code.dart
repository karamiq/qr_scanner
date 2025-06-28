import 'package:flutter/material.dart';
import '../../../common_lib.dart';
import '../../../data/models/qr_type_enum.dart';

class GenerateLocationQRCode extends HookWidget {
  const GenerateLocationQRCode({
    super.key,
    required this.type,
    required this.onChange,
  });

  final QRType type;
  final void Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    final latitude = useTextEditingController();
    final longitude = useTextEditingController();
    void updateQRData() {
      String qrData = '''https://www.google.com/maps?q=${latitude.text},${longitude.text}'

''';

      onChange(qrData);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: ColumnPadded(
        gap: Insets.medium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Latitude'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: latitude,
                      hintText: 'Enter latitude',
                      validator: context.validator.required().build(),
                      onChanged: (value) => updateQRData(),
                    ),
                  ],
                ),
              ),
              const Gap(Insets.large),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Longitude'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: longitude,
                      hintText: 'Enter longitude',
                      validator: context.validator.required().build(),
                      onChanged: (value) => updateQRData(),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
