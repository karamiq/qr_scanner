import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/data/shared_preference/preferences.dart';
import 'package:app/common_lib.dart';
import 'package:app/src/components/qr_icon_option.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/clients/_clients.dart';
import 'components/settings_option.dart';
part 'settings_page.g.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: const Color(0xFF525252),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
            child: ColumnPadded(
              crossAxisAlignment: CrossAxisAlignment.start,
              gap: Insets.small,
              children: [
                const Gap(0),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(const Color(0xFF333333)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () => context.pop(),
                  icon: SvgPicture.asset(Assets.assetsSvgArrowBack),
                ),
                const Gap(Insets.small),
                const Text(
                  'Settings',
                  style: TextStyle(color: Color(0xFFFDB623), fontSize: 26),
                ),
                const Gap(Insets.medium),
                SettingsOption(
                  title: 'Vibration',
                  subtitle: 'Vibration when scan is done.',
                  iconPath: Assets.assetsSvgPhoneViberate,
                  useSwitch: true,
                  switchValueFuture: ref.watch(getVibrationProvider.future),
                  onChange: (p0) async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool(Preferences.vibration, p0);
                  },
                ),
                const Gap(Insets.small),
                SettingsOption(
                  title: 'Beep',
                  subtitle: 'Beep when scan is done.',
                  iconPath: Assets.assetsSvgPhoneViberate,
                  useSwitch: true,
                  switchValueFuture: ref.watch(getBeepProvider.future),
                  onChange: (p0) async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool(Preferences.beep, p0);
                  },
                ),
                const Gap(Insets.small),
                Row(
                  children: [
                    QRIconOption(
                        icon: Icons.delete_forever,
                        text: 'Clear History',
                        onPressed: () =>
                            ref.read(deleteQRDataProviderProvider.notifier).deleteTable())
                  ],
                ),
                const Gap(Insets.small),
                const Text(
                  'Support',
                  style: TextStyle(color: Color(0xFFFDB623), fontSize: 26),
                ),
                const Gap(Insets.medium),
                SettingsOption(
                  title: 'Rate Us',
                  subtitle: 'Your best reward to us.',
                  iconPath: Assets.assetsSvgRateUs,
                  useSwitch: false,
                  onTap: () {},
                ),
                const Gap(Insets.small),
                SettingsOption(
                  title: 'Privacy Policy',
                  subtitle: 'Follow our policies that benefits you.',
                  iconPath: Assets.assetsSvgShield,
                  useSwitch: false,
                  onTap: () {},
                ),
                const Gap(Insets.small),
                SettingsOption(
                  title: 'Share',
                  subtitle: 'Share app with others.',
                  iconPath: Assets.assetsSvgShare,
                  useSwitch: false,
                  onTap: () {},
                ),
                const Gap(Insets.medium),
              ],
            ),
          ),
        ));
  }
}

@riverpod
Future<bool> getVibration(GetVibrationRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final res = prefs.getBool(Preferences.vibration) ?? true;

  return res;
}

@riverpod
Future<bool> getBeep(GetBeepRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final res = prefs.getBool(Preferences.beep) ?? true;
  return res;
}
