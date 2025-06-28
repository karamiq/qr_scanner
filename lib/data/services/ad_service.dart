import 'dart:math';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../utils/constants/admob_constants.dart';

class AdService {
  static String get bannerAdUnitId => AdMobConstants.bannerAdUnitId;
  // The interstitialAd is currently not used
  static String get interstitialAdUnitId => AdMobConstants.interstitialAdUnitId;

  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialAdReady = false;

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();

    await loadInterstitialAd();
  }

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
  }

  static Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  static Future<void> showInterstitialAd() async {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      await _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialAdReady = false;

      await loadInterstitialAd();
    } else {
      await loadInterstitialAd();
    }
  }

  static Future<void> showRandomInterstitialAd() async {
    final random = Random();
    if (random.nextInt(7) == 0) {
      await showInterstitialAd();
    }
  }
}
