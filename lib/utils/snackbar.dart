import 'package:app/common_lib.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/app_colors.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showErrorSnackBar(String? text) {
    if (text == null) return;
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(color: AppColors.textWhite),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.warning.withAlpha(200),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSuccessSnackBar(String? text) {
    if (text == null) return;
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(color: AppColors.primary),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.background,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar,
          snackBarAnimationStyle: const AnimationStyle(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 300),
              reverseDuration: Duration(milliseconds: 300),
              reverseCurve: Curves.easeOut));
  }

  static showNotificatonSnackBar(String? title) {
    if (title == null) return;
    SnackBar snackBar = SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: Text(title),
      behavior: SnackBarBehavior.floating,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

extension SnackBarX on BuildContext {
  void showSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: theme.colorScheme.error,
      ),
    );
  }

  void showSuccessSnackBar(String text) {
    // final theme = Theme.of(this);

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showErrorSnackBar(String text) {
    final theme = Theme.of(this);

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: theme.colorScheme.onError,
          ),
        ),
        backgroundColor: theme.colorScheme.error,
      ),
    );
  }
}
