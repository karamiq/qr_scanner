import 'dart:math';

import 'package:flutter/material.dart';

import 'scan_spot_clipper.dart';
import '../../../theme/app_colors.dart';

class ScanSpot extends StatelessWidget {
  const ScanSpot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -.5),
      child: SizedBox(
        width: 250,
        height: 250,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Transform.flip(
                flipX: true,
                child: Transform.rotate(
                  angle: pi,
                  child: ClipPath(
                    clipper: ScanSpotClipper(),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Transform.flip(
                flipX: true,
                flipY: true,
                child: ClipPath(
                  clipper: ScanSpotClipper(),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ClipPath(
                clipper: ScanSpotClipper(),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Transform.flip(
                flipX: true,
                child: ClipPath(
                  clipper: ScanSpotClipper(),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
