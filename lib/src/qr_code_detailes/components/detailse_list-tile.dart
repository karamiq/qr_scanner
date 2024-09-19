import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/qr_data_model.dart';
import '../../../common_lib.dart';

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
        style: const TextStyle(
          color: Color(0xFFD9D9D9),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Text(
        DateFormat('dd MMM yyyy, hh:mm a').format(item.date),
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFFA4A4A4),
        ),
      ),
    );
  }
}
