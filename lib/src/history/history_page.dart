import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/src/components/custom_bottom_navigation_bar.dart';
import 'package:app/src/history/components/create_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_lib.dart';
import '../../utils/components/scaffold_decoration.dart';
import 'components/scan_page.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          color: Color(0xFF525252),
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
                decoration:
                    const BoxDecoration(color: Color(0xFF4d4d4d), shape: BoxShape.circle),
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
                          style: TextStyle(fontSize: 26, color: Color(0xFFD9D9D9)),
                        ),
                        IconButton.filled(
                            style: IconButton.styleFrom(
                                backgroundColor: const Color(0xFF333333),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () => context.pushNamed(RoutesDocument.settings),
                            icon: SvgPicture.asset(Assets.assetsSvgMenu))
                      ],
                    ),
                  ),
                  Container(
                    width: 340,
                    decoration: const BoxDecoration(
                      borderRadius: BorderSize.extraSmallRadius,
                      color: Color(0xFF333333),
                    ),
                    child: TabBar(
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.itim().fontFamily,
                      ),
                      controller: tabController,
                      unselectedLabelColor: const Color(0xFFD9D9D9),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                          borderRadius: BorderSize.extraSmallRadius,
                          color: Theme.of(context).colorScheme.primary,
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0,
                                1
                              ],
                              colors: [
                                Color(0xFFFDB623),
                                Color(0x4FFDB623),
                              ])),
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
