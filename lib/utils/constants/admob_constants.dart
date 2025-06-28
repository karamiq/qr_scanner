import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobConstants {
  // App IDs
  static String get androidAppId => dotenv.env['APP_ID'] ?? '';

  // Ad Unit IDs
  static String get bannerAdUnitId => dotenv.env['BANNER_AD_UNIT_ID'] ?? '';
  static String get interstitialAdUnitId => dotenv.env['INTERSTITIAL_AD_UNIT_ID'] ?? '';
}
