import 'package:flutter/material.dart';

import '../../common_lib.dart';
import 'bottom_navigatoin_item.dart';

final currentPageIndexProvider = StateProvider<int>((ref) => 1);

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentIndex = ref.watch(currentPageIndexProvider);
    void onItemTapped(int index) {
      print(index);
      ref.read(currentPageIndexProvider.notifier).state = index;
    }

    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Container(
          padding: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFFDB623),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF333333),
                  blurRadius: 15,
                ),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: const Color(0xFFFDB623),
              unselectedItemColor: const Color(0xFFD9D9D9),
              backgroundColor: const Color(0xFF333333),
              items: [
                bottomNavigationItem(icon: Assets.assetsSvgQrCode, title: 'Generated'),
                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: '',
                ),
                bottomNavigationItem(icon: Assets.assetsSvgHistory, title: 'History'),
              ],
              onTap: onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
