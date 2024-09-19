import 'package:flutter/material.dart';
import '../../../common_lib.dart';

class GenerateWifiQRCode extends HookWidget {
  const GenerateWifiQRCode({super.key, required this.onChange});
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();

    void updateQRCode() {
      final s = '''WIFI:T:WPA;S:${nameController.text};P:${passwordController.text};;''';
      onChange(s);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Network'),
          const Gap(Insets.small),
          CustomTextFormField(
            onChanged: (value) => updateQRCode(),
            controller: nameController,
            hintText: 'Enter network name',
            validator: context.validator.required().build(),
          ),
          const Gap(Insets.large),
          const Text('Password'),
          const Gap(Insets.small),
          CustomTextFormField(
            onChanged: (value) => updateQRCode(),
            controller: passwordController,
            hintText: 'Enter password',
            validator: context.validator.required().build(),
          ),
        ],
      ),
    );
  }
}
