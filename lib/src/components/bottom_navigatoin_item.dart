// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../common_lib.dart';
import '../../theme/app_colors.dart';

BottomNavigationBarItem bottomNavigationItem({required String icon, required String title}) {
  return BottomNavigationBarItem(
    backgroundColor: Colors.transparent,
    activeIcon: SvgPicture.asset(
      icon,
      color: AppColors.primary,
    ),
    icon: SvgPicture.asset(
      icon,
      color: AppColors.textPrimary,
    ),
    label: title,
    tooltip: title,
  );
}
