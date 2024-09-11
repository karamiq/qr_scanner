import 'package:app/common_lib.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showErrorSnackBar(String? text) {
    if (text == null) return;
    SnackBar snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorSchemeNotifier.value.error,
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
        style: const TextStyle(color: Color(0xFFFDB623)),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF333333),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar,
          snackBarAnimationStyle: AnimationStyle(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              reverseCurve: Curves.easeOut));
  }

  static showNotificatonSnackBar(String? title) {
    if (title == null) return;
    SnackBar snackBar = SnackBar(
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
