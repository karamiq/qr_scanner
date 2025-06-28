import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/src/components/custom_bottom_navigation_bar.dart';
import 'package:app/src/history/components/create_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common_lib.dart';
import '../../utils/components/scaffold_decoration.dart';
import '../../theme/app_colors.dart';
import 'components/scan_page.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int pageIndex = ref.watch(currentPageIndexProvider);
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: pageIndex != 2 ? MediaQuery.of(context).size.width : 0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.backgroundDark,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const PageDecoration(
              top: -50,
              right: -130,
            ),
            const PageDecoration(
              bottom: -5,
              left: -250,
            ),
            Positioned(
              bottom: 280,
              left: 30,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                padding: const EdgeInsets.all(100),
                decoration: const BoxDecoration(color: AppColors.backgroundMedium, shape: BoxShape.circle),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'History',
                          style: TextStyle(fontSize: 26, color: AppColors.textPrimary),
                        ),
                        IconButton.filled(
                            style: IconButton.styleFrom(
                                backgroundColor: AppColors.background,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            onPressed: () => context.pushNamed(RoutesDocument.settings),
                            icon: SvgPicture.asset(
                              Assets.assetsSvgMenu,
                              color: AppColors.primary,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    width: 340,
                    decoration: const BoxDecoration(
                      borderRadius: BorderSize.extraSmallRadius,
                      color: AppColors.background,
                    ),
                    child: TabBar(
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.itim().fontFamily,
                      ),
                      controller: tabController,
                      unselectedLabelColor: AppColors.textPrimary,
                      dividerColor: AppColors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.textWhite,
                      indicator: BoxDecoration(
                          borderRadius: BorderSize.extraSmallRadius,
                          color: Theme.of(context).colorScheme.primary,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 1],
                              colors: AppColors.primaryGradient)),
                      padding: const EdgeInsets.all(10),
                      tabs: const [
                        Tab(text: 'Scan'),
                        Tab(text: 'Create'),
                      ],
                    ),
                  ),
                  const Gap(Insets.extraSmall),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ref.watch(getQRDataHistoryProvider).when(
                            data: (data) => ScanPage(
                                  data: data.reversed.toList(),
                                ),
                            error: (erro, track) => Center(
                                  child: Text('Error: $erro'),
                                ),
                            loading: () => const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )),
                        const CreatePage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
