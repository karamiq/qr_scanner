import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/common_lib.dart';
import 'package:app/data/shared_preference/shared_preferences_lib.dart';
import 'package:app/utils/widgets/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import '../../data/services/clients/_clients.dart';
import '../../theme/app_colors.dart';
import 'components/settings_option.dart';
part 'settings_page.g.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
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
                  backgroundColor: WidgetStateProperty.all(AppColors.background),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: () => context.pop(),
                icon: SvgPicture.asset(
                  Assets.assetsSvgArrowBack,
                  color: AppColors.primary,
                ),
              ),
              const Gap(Insets.small),
              const Text(
                'Settings',
                style: TextStyle(color: AppColors.primary, fontSize: 26),
              ),
              const Gap(Insets.medium),
              SettingsOption(
                title: 'Vibration',
                subtitle: 'Vibrate when scan is done.',
                iconPath: Assets.assetsSvgPhoneViberate,
                useSwitch: true,
                switchValueFuture: ref.watch(getVibrationProvider).value,
                onChange: (p0) {
                  final prefs = ref.read(sharedPreferencesProvider);
                  prefs.setBool(Preferences.vibration, p0);
                },
              ),
              const Gap(Insets.small),
              SettingsOption(
                title: 'Beep',
                subtitle: 'Beep sound when scan is done.',
                iconPath: Assets.assetsSvgPhoneViberate,
                useSwitch: true,
                switchValueFuture: ref.watch(getBeepProvider).value,
                onChange: (p0) {
                  final prefs = ref.read(sharedPreferencesProvider);
                  prefs.setBool(Preferences.beep, p0);
                },
              ),
              const Gap(Insets.small),
              SettingsOption(
                title: 'Clear History',
                subtitle: 'Remove all your scanned QR code history.',
                iconPath: Assets.assetsSvgTrash,
                useSwitch: false,
                onTap: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.background,
                      title: const Text('Clear History'),
                      content: const Text('Are you sure you want to clear your history?'),
                      actions: [
                        TextButton(onPressed: () => context.pop(false), child: const Text('Cancel')),
                        TextButton(onPressed: () => context.pop(true), child: const Text('Clear')),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    // ignore: unused_result
                    ref.read(deleteQRDataProviderProvider.notifier).deleteTable();
                  }
                },
              ),
              const Gap(Insets.small),
              // const Text(
              //   'Support',
              //   style: TextStyle(color: AppColors.primary, fontSize: 26),// ),
              // const Gap(Insets.medium),
              // SettingsOption(
              //   title: 'Rate Us',
              //   subtitle: 'Your best reward to us.',
              //   iconPath: Assets.assetsSvgRateUs,
              //   useSwitch: false,
              //   onTap: () {},
              // ),
              // const Gap(Insets.small),
              // SettingsOption(
              //   title: 'Privacy Policy',
              //   subtitle: 'Follow our policies that benefits you.',
              //   iconPath: Assets.assetsSvgShield,
              //   useSwitch: false,
              //   onTap: () {},
              // ),
              // const Gap(Insets.small),
              // SettingsOption(
              //   title: 'Share',
              //   subtitle: 'Share app with others.',
              //   iconPath: Assets.assetsSvgShare,
              //   useSwitch: false,
              //   onTap: () {},
              // ),
              // const Gap(Insets.medium),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}

@riverpod
bool getVibration(Ref ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  final res = prefs.getBool(Preferences.vibration) ?? true;

  return res;
}

@riverpod
bool getBeep(Ref ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  final res = prefs.getBool(Preferences.beep) ?? true;
  return res;
}
