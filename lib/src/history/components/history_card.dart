import 'package:app/data/services/local_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_lib.dart';
import '../../../data/models/qr_data_model.dart';
import '../../../data/providers/qr_data_provider.dart';

class HistoryCard extends ConsumerWidget {
  const HistoryCard({
    super.key,
    required this.item,
  });

  final QrDataModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF333333),
        boxShadow: [
          BoxShadow(
            color: Color(0xA0000000),
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        onTap: () => context.push(
          RoutesDocument.qrDetails(item.id),
          extra: item,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: Insets.small + 2),
        leading: Image.asset(
          Assets.assetsImagesQrLeading,
          width: 40,
          height: 40,
        ),
        title: Text(
          item.data,
          maxLines: 1,
          style: const TextStyle(
            color: Color(0xFFD9D9D9),
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          '${item.type[0].toUpperCase()}${item.type.substring(1)}',
          style: const TextStyle(
            color: Color(0xFFA4A4A4),
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                // ignore: unused_result
                ref.read(deleteQRDataProvider.notifier).deleteQRdata(item.id);
              },
              child: SvgPicture.asset(Assets.assetsSvgTrash),
            ),
            const SizedBox(height: Insets.extraSmall),
            Text(DateFormat('dd MMM yyyy, hh:mm a').format(item.date)),
          ],
        ),
      ),
    );
  }
}
