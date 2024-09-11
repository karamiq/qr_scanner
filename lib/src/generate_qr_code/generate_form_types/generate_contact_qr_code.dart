import 'package:flutter/material.dart';
// For date formatting

import '../../../common_lib.dart';
import '../../../data/models/qr_type_enum.dart';

class GenerateContactQRCode extends HookWidget {
  const GenerateContactQRCode({
    super.key,
    required this.type,
    required this.onChange,
  });

  final QRType type;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final firstController = useTextEditingController();
    final lastController = useTextEditingController();
    final companyController = useTextEditingController();
    final jobController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final cityController = useTextEditingController();
    final governorateController = useTextEditingController();
    final websiteController = useTextEditingController();
    final streetController = useTextEditingController();

    void updateQRData() {
      final String firstName = firstController.text;
      final String lastName = lastController.text;
      final String company = companyController.text;
      final String jobTitle = jobController.text;
      final String phone = phoneController.text;
      final String email = emailController.text;
      final String city = cityController.text;
      final String country = governorateController.text;
      final String website = websiteController.text;
      final String address = streetController.text;

// Create the VCard string
      String vCard = '''
BEGIN:VCARD
VERSION:3.0
FN:$firstName $lastName
ORG:$company
TITLE:$jobTitle
TEL:$phone
EMAIL:$email
ADR:;;$address;$city;$country
URL:$website
END:VCARD
''';
      onChange(vCard);
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
                    const Text('First name'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: firstController,
                      hintText: 'Enter name',
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
                    const Text('Last name'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: lastController,
                      hintText: 'Enter name',
                      validator: context.validator.required().build(),
                      onChanged: (value) => updateQRData(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Company'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: companyController,
                      hintText: 'Enter company',
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
                    const Text('Job'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: jobController,
                      hintText: 'Enter job',
                      validator: context.validator.required().build(),
                      onChanged: (value) => updateQRData(),
                    ),
                  ],
                ),
              ),
            ],
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
          const Text('Street'),
          CustomTextFormField(
            controller: streetController,
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
                    const Text('Governorate'),
                    const SizedBox(height: Insets.small),
                    CustomTextFormField(
                      controller: governorateController,
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