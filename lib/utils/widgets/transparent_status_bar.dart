import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/theme/app_colors.dart';

class TransparentStatusBar extends StatelessWidget {
  const TransparentStatusBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
      child: child,
    );
  }
}
