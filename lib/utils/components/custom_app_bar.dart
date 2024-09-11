import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this is the correct package import for SVG assets
import 'package:app/utils/constants/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFFD9D9D9)),
      ),
      backgroundColor: Colors.transparent,
      leading: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: const Color(0xFF333333),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          print('Go back go back');
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(Assets.assetsSvgArrowBack),
      ),
    );
  }

  // This specifies the size of the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
