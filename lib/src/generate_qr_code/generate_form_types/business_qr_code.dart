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
MECARD:
N:${companyNameController.text}
ORG:${industryController.text}
TEL:${phoneController.text}
EMAIL:${emailController.text}
URL:${websiteController.text}
ADR:${addressController.text},${cityController.text},${countryController.text}
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
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      hintText: 'Enter phone',
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: 'Enter email',
                      onChanged: (value) => updateQRData(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Text('Website'),
          CustomTextFormField(
            keyboardType: TextInputType.url,
            controller: websiteController,
            hintText: 'Enter website',
            onChanged: (value) => updateQRData(),
          ),
          const Text('Adress'),
          CustomTextFormField(
            controller: addressController,
            hintText: 'Enter street',
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
