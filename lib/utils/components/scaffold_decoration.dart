import 'package:flutter/material.dart';

class PageDecoration extends StatelessWidget {
  const PageDecoration({
    super.key,
    this.top,
    this.bottom,
    this.right,
    this.left,
  });
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: Container(
          height: 400,
          width: 400,
          padding: const EdgeInsets.all(100),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF5f6064)),
              color: const Color(0xFF4f4f4f),
              shape: BoxShape.circle),
          child: Container(
            height: 200,
            width: 200,
            decoration:
                const BoxDecoration(color: Color(0xFF4d4d4d), shape: BoxShape.circle),
          ),
        ));
  }
}
