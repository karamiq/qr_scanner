import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFFFDB623);

  // Background Colors
  static const Color background = Color(0xFF333333);
  static const Color backgroundLight = Color(0xFF3B3B3B);
  static const Color backgroundMedium = Color(0xFF4d4d4d);
  static const Color backgroundDark = Color(0xFF525252);
  static const Color surface = Color(0xFF3C3C3C);
  static const Color backgroundExtraDark = Color(0xFF4f4f4f);

  // Text Colors
  static const Color textPrimary = Color(0xFFD9D9D9);
  static const Color textSecondary = Color(0xFFA4A4A4);
  static const Color textMuted = Color(0xFF858585);
  static const Color textWhite = Colors.white;
  static const Color textDefault = Color(0xff202020);

  // Border Colors
  static const Color border = Color(0xFFD9D9D9);
  static const Color borderLight = Color(0xFF5f6064);

  // Status Colors
  static const Color success = Color(0xFF198754);
  static const Color error = Color(0xFFDC3747);
  static const Color warning = Color(0xFFFF6347);
  static const Color info = Color(0xFF035EC9);

  // Additional Colors
  static const Color flashOn = Color(0xFFFFC107);
  static const Color flashOff = Color(0xFFD9D9D9);
  static const Color overlay = Color.fromARGB(255, 226, 40, 40);
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;

  // Opacity variants
  static Color get backgroundWithOpacity => background.withOpacity(0.84);
  static Color get backgroundLightWithOpacity => backgroundLight.withOpacity(0.84);
  static Color get textPrimaryWithOpacity => textPrimary.withOpacity(0.34);
  static Color get blackWithOpacity => black.withOpacity(0.63);

  // Gradient colors
  static List<Color> get primaryGradient => [
        primary,
        primary.withOpacity(0.3),
      ];

  // Extension colors (for backward compatibility)
  static const Color primaryText = Color(0xff035EC9);
  static const Color secondaryText = Color(0xFF7C7C7C);
  static const Color defaultText = Color(0xff202020);
  static const Color otherText = Color(0xffFD7E14);
  static const Color successText = Color(0xff198754);
  static const Color dangerColor = Color(0xffDC3747);
}
