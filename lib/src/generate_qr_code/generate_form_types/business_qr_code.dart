import 'package:flutter/material.dart';
// For date formatting

import '../../../common_lib.dart';
import '../../../data/models/qr_type_enum.dart';

class GenerateBusinessQRCode extends HookWidget {
  const GenerateBusinessQRCode({
    super.key,
    required this.type,
    required this.onChange,
  });

  final QRType type;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final companyNameController = useTextEditingController();
    final industryController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final websiteController = useTextEditingController();

    final addressController = useTextEditingController();
    final cityController = useTextEditingController();
    final countryController = useTextEditingController();
    void updateQRData() {
      String qrData = '''
BEGIN:VCARD
VERSION:3.0
FN:${companyNameController.text}
ORG:${industryController.text}
TEL:${phoneController.text}
EMAIL:${emailController.text}
URL:${websiteController.text}
ADR:;;${addressController.text};${cityController.text};${countryController.text}
END:VCARD
''';

      onChange(qrData);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: ColumnPadded(
        gap: Insets.medium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Company name'),
          CustomTextFormField(
            controller: companyNameController,
            hintText: 'Enter name',
            validator: context.validator.required().build(),
            onChanged: (value) => updateQRData(),
          ),
          const Text('Industry'),
          CustomTextFormField(
            controller: industryController,
            hintText: 'e.g Food/Agency',
            validator: context.validator.required().build(),
            onChanged: (value) => updateQRData(),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Phone'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: phoneController,
                      hintText: 'Enter phone',
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
                    const Text('Email'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Enter email',
                      validator: context.validator.required().build(),
                      onChanged: (value) => updateQRData(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Text('Website'),
          CustomTextFormField(
            controller: websiteController,
            hintText: 'Enter website',
            validator: context.validator.required().build(),
            onChanged: (value) => updateQRData(),
          ),
          const Text('Adress'),
          CustomTextFormField(
            controller: addressController,
            hintText: 'Enter street',
            validator: context.validator.required().build(),
            onChanged: (value) => updateQRData(),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('City'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: cityController,
                      hintText: 'Enter city',
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
                    const Text('Country'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: countryController,
                      hintText: 'Enter governorate',
                      validator: context.validator.required().build(),
                      onChanged: (value) => updateQRData(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
