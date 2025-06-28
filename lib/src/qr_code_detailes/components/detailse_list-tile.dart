import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/qr_data_model.dart';
import '../../../common_lib.dart';
import '../../../theme/app_colors.dart';

class DetailesListTile extends StatelessWidget {
  const DetailesListTile({
    super.key,
    required this.item,
  });

  final QrDataModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Insets.small + 2),
      leading: Image.asset(
        Assets.assetsImagesAppIconDark,
      ),
      title: Text(
        '${item.type[0].toUpperCase()}${item.type.substring(1)}',
        maxLines: 1,
        style: TextStyle(
          color: AppColors.textPrimary,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Text(
        DateFormat('dd MMM yyyy, hh:mm a').format(item.date),
        style: TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
