import 'package:app/src/components/scan_button.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.transparent,
        body: child,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const ScanButton());
  }
}
