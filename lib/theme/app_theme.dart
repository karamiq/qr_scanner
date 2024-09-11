import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          bodyLarge: const TextStyle(color: Color(0xFFD9D9D9)),
          bodyMedium: const TextStyle(color: Color(0xFFD9D9D9)),
          displayLarge: const TextStyle(color: Color(0xFFD9D9D9)),
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
      fillColor: const Color(0xFF333333),
      filled: true,
      activeIndicatorBorder: BorderSide.none,
      border: buildBorder(
        const Color(0xFFD9D9D9),
      ),
      hintStyle: TextStyle(color: const Color(0xFFD9D9D9).withOpacity(.34)),
      labelStyle: TextStyle(color: const Color(0xFFD9D9D9).withOpacity(.34)),
      errorBorder: buildBorder(colorScheme.error, width: 1.2),
      enabledBorder: buildBorder(
        const Color(0xFFD9D9D9),
      ),
      focusedBorder: buildBorder(const Color(0xFFFDB623), width: 1.5),
      focusedErrorBorder: buildBorder(colorScheme.error, width: 1.5),
      disabledBorder: buildBorder(colorScheme.outline.withOpacity(0.5)),
    );
  }

  TextTheme _buildTextTheme(TextTheme textTheme) {
    return GoogleFonts.itimTextTheme(textTheme);
  }

  ExtraColors buildExtraColors() {
    return const ExtraColors(
      success: Color.fromARGB(255, 28, 101, 30),
      onSuccess: Colors.white,
      error: Color.fromARGB(255, 255, 0, 0),
    );
  }

  ColorScheme _buildColorScheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFFDB623),
      primary: const Color(0xFFFDB623),
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
      backgroundColor: const Color(0xFF333333),
      //

      dayPeriodColor: colorScheme.primary.withOpacity(1),
      dayPeriodTextColor:
          WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected)
              ? const Color(0xFF333333) // Color when AM/PM is selected
              : const Color(0xFFD9D9D9)),
      //
      dayPeriodTextStyle: const TextStyle(color: Colors.green),
      dialTextColor: const Color(0xFFD9D9D9),
      dialTextStyle: TextStyle(
        fontSize: 20,
        fontFamily: GoogleFonts.itim().fontFamily,
      ),
      hourMinuteColor: const Color(0xFF3B3B3B).withOpacity(.84),
      hourMinuteTextColor: const Color(0xFFD9D9D9),

      entryModeIconColor: colorScheme.primary,
      dialBackgroundColor: const Color(0xFF3B3B3B).withOpacity(.84),
    );
  }

  DatePickerThemeData _buildDatePickerTheme() => const DatePickerThemeData(
        weekdayStyle: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        headerHelpStyle: TextStyle(
          color: Color(
            0xFFD9D9D9,
          ),
        ),
        dividerColor: Color(0xFFD9D9D9),
        headerForegroundColor: Color(0xFFD9D9D9),
        dayOverlayColor: WidgetStatePropertyAll(Color.fromARGB(255, 226, 40, 40)),
        yearForegroundColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
        dayForegroundColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
        backgroundColor: Color(0xFF333333),
      );
}

final colorSchemeNotifier = ValueNotifier<ColorScheme>(ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 17, 61, 128),
  brightness: AppTheme().getBrightness(),
));
