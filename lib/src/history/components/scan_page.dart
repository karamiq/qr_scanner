import 'package:flutter/material.dart';
import '../../../data/models/qr_data_model.dart';
import '../../../theme/app_colors.dart';
import 'history_card.dart';
import '../../../common_lib.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({
    super.key,
    required this.data,
  });

  final List<QrDataModel>? data;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Column(
      //The column is neccessery to make the [SizedBox] works
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .635,
          margin: const EdgeInsets.symmetric(horizontal: Insets.medium, vertical: Insets.small),
          decoration: BoxDecoration(
              color: AppColors.backgroundWithOpacity, borderRadius: BorderSize.extraSmallRadius),
          child: data == null
              ? const Center(child: Text('Data is not available'))
              : data!.isEmpty
                  ? const Center(
                      child: Text(
                        'History is empty',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : Scrollbar(
                      interactive: true,
                      controller: scrollController,
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: data!.length,
                        padding: const EdgeInsets.all(Insets.medium),
                        itemBuilder: (context, index) {
                          final item = data![index];
                          return HistoryCard(item: item);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: Insets.medium),
                      ),
                    ),
        ),
      ],
    );
  }
}
