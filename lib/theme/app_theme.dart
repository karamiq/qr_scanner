import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'extra_colors.dart';

class AppTheme {
  ThemeData _build(Brightness brightness) {
    final themeData = ThemeData(
        useMaterial3: true,
        brightness: brightness,
        extensions: [buildExtraColors()],
        inputDecorationTheme: _buildInputDecorationTheme(brightness),
        colorScheme: _buildColorScheme(brightness),
        filledButtonTheme: _buildFilledButtonTheme(brightness),
        outlinedButtonTheme: _buildOutlinedButtonTheme(brightness),
        textButtonTheme: _buildTextButtonTheme(brightness),
        textTheme: const TextTheme().copyWith(
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textPrimary),
          displayLarge: TextStyle(color: AppColors.textPrimary),
        ),
        timePickerTheme: _buildtimePickerTheme(brightness),
        datePickerTheme: _buildDatePickerTheme());

    return themeData.copyWith(
      textTheme: _buildTextTheme(themeData.textTheme),
    );
  }

  final borderRadius = BorderRadius.circular(BorderSize.extraSmall);
  final padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 14);

  Brightness getBrightness() {
    return currentBrightness.value;
  }

  final currentBrightness = ValueNotifier<Brightness>(Brightness.light);

  ThemeData buildDarkTheme() {
    currentBrightness.value = Brightness.dark;
    return _build(Brightness.dark);
  }

  ThemeData buildLightTheme() {
    currentBrightness.value = Brightness.light;
    return _build(Brightness.light);
  }

  InputDecorationTheme _buildInputDecorationTheme(Brightness brightness) {
    final colorScheme = _buildColorScheme(brightness);

    OutlineInputBorder buildBorder(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      fillColor: AppColors.background,
      filled: true,
      activeIndicatorBorder: BorderSide.none,
      border: buildBorder(AppColors.border),
      hintStyle: TextStyle(color: AppColors.textPrimaryWithOpacity),
      labelStyle: TextStyle(color: AppColors.textPrimaryWithOpacity),
      errorBorder: buildBorder(colorScheme.error, width: 1.2),
      enabledBorder: buildBorder(AppColors.border),
      focusedBorder: buildBorder(AppColors.primary, width: 1.5),
      focusedErrorBorder: buildBorder(colorScheme.error, width: 1.5),
      disabledBorder: buildBorder(colorScheme.outline.withOpacity(0.5)),
    );
  }

  TextTheme _buildTextTheme(TextTheme textTheme) {
    return GoogleFonts.itimTextTheme(textTheme);
  }

  ExtraColors buildExtraColors() {
    return const ExtraColors(
      success: AppColors.success,
      onSuccess: AppColors.textWhite,
      error: AppColors.error,
    );
  }

  ColorScheme _buildColorScheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: brightness,
    );

    return colorScheme.copyWith(
      outline: colorScheme.outline.withOpacity(0.5),
    );
  }

  FilledButtonThemeData _buildFilledButtonTheme(Brightness brightness) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 55),
        maximumSize: const Size(double.infinity, double.infinity),
        // padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  OutlinedButtonThemeData _buildOutlinedButtonTheme(Brightness brightness) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  TextButtonThemeData _buildTextButtonTheme(Brightness brightness) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  TimePickerThemeData _buildtimePickerTheme(Brightness brightness) {
    final colorScheme = _buildColorScheme(brightness);

    return TimePickerThemeData(
      backgroundColor: AppColors.background,
      //

      dayPeriodColor: colorScheme.primary.withOpacity(1),
      dayPeriodTextColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected)
          ? AppColors.background // Color when AM/PM is selected
          : AppColors.textPrimary),
      //
      dayPeriodTextStyle: TextStyle(color: AppColors.success),
      dialTextColor: AppColors.textPrimary,
      dialTextStyle: TextStyle(
        fontSize: 20,
        fontFamily: GoogleFonts.itim().fontFamily,
      ),
      hourMinuteColor: AppColors.backgroundLightWithOpacity,
      hourMinuteTextColor: AppColors.textPrimary,

      entryModeIconColor: colorScheme.primary,
      dialBackgroundColor: AppColors.backgroundLightWithOpacity,
    );
  }

  DatePickerThemeData _buildDatePickerTheme() => DatePickerThemeData(
        weekdayStyle: TextStyle(
          fontSize: 18,
          color: AppColors.textWhite,
        ),
        headerHelpStyle: TextStyle(
          color: AppColors.textPrimary,
        ),
        dividerColor: AppColors.textPrimary,
        headerForegroundColor: AppColors.textPrimary,
        dayOverlayColor: WidgetStatePropertyAll(AppColors.overlay),
        yearForegroundColor: WidgetStatePropertyAll(AppColors.textPrimary),
        dayForegroundColor: WidgetStatePropertyAll(AppColors.textPrimary),
        backgroundColor: AppColors.background,
      );
}

final colorSchemeNotifier = ValueNotifier<ColorScheme>(ColorScheme.fromSeed(
  seedColor: AppColors.info,
  brightness: AppTheme().getBrightness(),
));
