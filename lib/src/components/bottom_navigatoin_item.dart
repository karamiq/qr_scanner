// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../common_lib.dart';

BottomNavigationBarItem bottomNavigationItem(
    {required String icon, required String title}) {
  return BottomNavigationBarItem(
    backgroundColor: Colors.transparent,
    activeIcon: SvgPicture.asset(
      icon,
      color: const Color(0xFFFDB623),
    ),
    icon: SvgPicture.asset(
      icon,
      color: const Color(0xFFD9D9D9),
    ),
    label: title,
    tooltip: title,
  );
}
