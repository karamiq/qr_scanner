import 'package:app/data/models/qr_data_model.dart';
import 'package:app/utils/components/custom_app_bar.dart';
import 'package:app/utils/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../common_lib.dart';
import '../components/qr_icon_option.dart';

class QrCodeDetailes extends StatelessWidget {
  const QrCodeDetailes({
    super.key,
    required this.item,
  });
  final QrDataModel item;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: ColumnPadded(
      gap: Insets.medium,
      children: [
        const CustomAppBar(title: 'Result'),
        const Gap(Insets.extraLarge),
        Container(
          height: 250,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderSize.extraSmallRadius,
              border: Border.all(color: const Color(0xFFFDB623), width: 4)),
          child: QrImageView(
            gapless: false,
            dataModuleStyle:
                const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square),
            foregroundColor: Colors.black,
            data: item.data,
            version: QrVersions.auto,
          ),
        ),
        const Gap(Insets.extraLarge),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: Insets.smallAll,
          decoration: const BoxDecoration(
            borderRadius: BorderSize.extraSmallRadius,
            color: Color(0xFFF3C3C3C),
          ),
          child: ColumnPadded(
            gap: Insets.extraSmall,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
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
              ),
              const Divider(
                color: Color(0xFF858585),
                thickness: .3,
                endIndent: 10,
                indent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  item.data,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: TextButton(onPressed: () {}, child: const Text('Open'))),
            ],
          ),
        ),
        const Gap(Insets.extraSmall),
        RowPadded(
          gap: Insets.extraLarge,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QRIconOption(
              icon: Icons.share,
              text: 'Share',
              onPressed: () {},
            ),
            QRIconOption(
              icon: Icons.file_copy,
              text: 'Copy',
              onPressed: () {},
            ),
            QRIconOption(
              icon: Icons.save,
              text: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ],
    ));
  }
}