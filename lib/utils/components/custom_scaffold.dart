import 'package:flutter/material.dart';

import 'package:app/theme/app_colors.dart';
import 'scaffold_decoration.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding,
    this.safeArea = true,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });
  final EdgeInsetsGeometry? padding;
  final Widget body;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool safeArea;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const PageDecoration(
            top: -50,
            right: -130,
          ),
          const PageDecoration(
            bottom: -5,
            left: -250,
          ),
          Positioned(
            bottom: 280,
            left: 30,
            right: 0,
            child: Container(
              height: 20,
              width: 20,
              padding: const EdgeInsets.all(100),
              decoration: BoxDecoration(color: AppColors.backgroundMedium, shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: padding ?? EdgeInsets.zero,
            child: body,
          ),
        ],
      ),
    );
  }
}
