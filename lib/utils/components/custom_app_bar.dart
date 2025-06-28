import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this is the correct package import for SVG assets
import 'package:app/utils/constants/assets.dart';
import 'package:app/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          title,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.transparent,
        leading: IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            Assets.assetsSvgArrowBack,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  // This specifies the size of the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
