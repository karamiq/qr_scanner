import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common_lib.dart';
import '../../../data/models/qr_data_model.dart';
import '../../../data/providers/qr_data_provider.dart';
import '../../../theme/app_colors.dart';

class HistoryCard extends ConsumerWidget {
  const HistoryCard({
    super.key,
    required this.item,
  });

  final QrDataModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWithOpacity,
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
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          '${item.type[0].toUpperCase()}${item.type.substring(1)}',
          style: const TextStyle(
            color: AppColors.textSecondary,
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
              child: SvgPicture.asset(
                Assets.assetsSvgTrash,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: Insets.extraSmall),
            Text(DateFormat('dd MMM yyyy, hh:mm a').format(item.date)),
          ],
        ),
      ),
    );
  }
}
