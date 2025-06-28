import 'package:flutter/material.dart';
import '../../common_lib.dart';

class QRIconOption extends StatelessWidget {
  const QRIconOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });
  final IconData icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ColumnPadded(
      gap: Insets.small,
      children: [
        IconButton.filled(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 40,
          ),
          style: IconButton.styleFrom(
              shape: const RoundedRectangleBorder(
            borderRadius: BorderSize.extraSmallRadius,
          )),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
