import 'package:flutter/material.dart';
import 'package:app/utils/constants/sizes.dart';
import 'package:app/theme/app_colors.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Time.small,
      height: 6,
      width: isActive ? 35 : 6,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.primary : AppColors.textPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(Insets.large)),
      ),
    );
  }
}
