import 'package:flutter/material.dart';
import '../../../common_lib.dart';

class GenerateTextQRCode extends HookWidget {
  const GenerateTextQRCode({super.key, required this.onChange});
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Text'),
          const Gap(Insets.small),
          CustomTextFormField(
            onChanged: (value) => onChange!(value ?? ''),
            controller: textEditingController,
            hintText: 'Enter text',
            validator: context.validator.required().build(),
          ),
        ],
      ),
    );
  }
}

class GenerateInternetQRCode extends HookWidget {
  const GenerateInternetQRCode({super.key, required this.onChange});
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Website URL'),
          const Gap(Insets.small),
          CustomTextFormField(
            keyboardType: TextInputType.url,
            onChanged: (value) => onChange!('https://$value'),
            controller: textEditingController,
            hintText: 'www.qrcode.com',
            validator: context.validator.required().build(),
          ),
        ],
      ),
    );
  }
}
