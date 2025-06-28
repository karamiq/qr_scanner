// import 'package:flutter/material.dart';
// import '../../data/services/ad_service.dart';

// class InterstitialAdWidget extends StatefulWidget {
//   const InterstitialAdWidget({super.key});

//   @override
//   State<InterstitialAdWidget> createState() => _InterstitialAdWidgetState();
// }

// class _InterstitialAdWidgetState extends State<InterstitialAdWidget> {
//   @override
//   void initState() {
//     super.initState();
//     debugPrint('InterstitialAdWidget: initState called');
//     _showInterstitialAd();
//   }

//   Future<void> _showInterstitialAd() async {
//     debugPrint('InterstitialAdWidget: Attempting to show interstitial ad');

//     // Add a small delay to ensure the widget is fully built
//     await Future.delayed(const Duration(milliseconds: 1000));

//     if (mounted) {
//       debugPrint('InterstitialAdWidget: Widget is still mounted, showing ad');
//       try {
//         await AdService.showInterstitialAd();
//         debugPrint('InterstitialAdWidget: Ad show request completed');
//       } catch (e) {
//         debugPrint('InterstitialAdWidget: Error showing ad: $e');
//       }
//     } else {
//       debugPrint('InterstitialAdWidget: Widget is no longer mounted');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     debugPrint('InterstitialAdWidget: build method called');
//     return const SizedBox.shrink();
//   }
// }
