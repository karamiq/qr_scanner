import 'package:flutter/material.dart';
import '../../../common_lib.dart';
import '../../../theme/app_colors.dart';

class CamTopOptions extends StatelessWidget {
  const CamTopOptions({
    super.key,
    required this.isFlashOn,
    required this.isFrontCamera,
    required this.selectImageFromGallery,
    required this.toggleFlash,
    required this.flipCamera,
  });

  final ValueNotifier<bool> isFlashOn;
  final ValueNotifier<bool> isFrontCamera;
  final VoidCallback selectImageFromGallery;
  final VoidCallback toggleFlash;
  final VoidCallback flipCamera;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium, vertical: Insets.small),
      decoration: const BoxDecoration(color: AppColors.background, borderRadius: BorderSize.extraSmallRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: selectImageFromGallery,
            icon: const Icon(
              Icons.photo_library,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: toggleFlash,
            icon: Icon(
              isFlashOn.value ? Icons.flash_on : Icons.flash_off,
              color: isFlashOn.value ? AppColors.primary : AppColors.flashOff,
            ),
          ),
          IconButton(
            onPressed: flipCamera,
            icon: Icon(
              Icons.flip_camera_android,
              color: !isFrontCamera.value ? AppColors.textPrimary : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
