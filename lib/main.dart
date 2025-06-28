import 'package:app/app.dart';
import 'package:app/data/services/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data/providers/provider.dart';

const String appName = 'QR Scanner';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  final sharedPreferences = await SharedPreferences.getInstance();
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  // Initialize AdService
  await AdService.initialize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
      ],
      child: const App(),
    ),
  );
}
