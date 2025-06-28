import 'package:app/src/components/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../common_lib.dart';
import '../../theme/app_colors.dart';

class ScanButton extends ConsumerWidget {
  const ScanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: GestureDetector(
        onTap: () {
          final index = ref.watch(currentPageIndexProvider);
          if (index != 3) {
          } else {}
          ref.read(currentPageIndexProvider.notifier).state = 1;
          print(ref.read(currentPageIndexProvider.notifier).state);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Container(
            height: 70,
            width: 70,
            padding: Insets.mediumAll,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary,
                  blurRadius: 15,
                )
              ],
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: SvgPicture.asset(Assets.assetsSvgScan),
          ),
        ),
      ),
    );
  }
}
