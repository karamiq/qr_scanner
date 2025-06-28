import 'package:app/src/camera/camera_page.dart';
import 'package:app/src/generate_qr_code/generate_qr_code_page.dart';
import 'package:app/src/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/models/qr_data_model.dart';
import '../data/models/qr_type_enum.dart';
import '../src/qr_code_detailes/qr_code_detailes.dart';

final Provider<GoRouter> routerProvider = Provider((ref) => router);

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutesDocument.camera,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RoutesDocument.camera,
      name: RoutesDocument.camera,
      builder: (context, state) => const CameraPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RoutesDocument.generate,
      name: RoutesDocument.generate,
      builder: (context, state) {
        final type = state.extra as QRType;
        return GenerateQrCodePage(
          type: type,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RoutesDocument.settings,
      name: RoutesDocument.settings,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: RoutesDocument.qrDetails(':id'),
      builder: (context, state) {
        //final id = state.pathParameters['id']!;
        final data = state.extra as QrDataModel;
        return QrCodeDetailes(
          item: data,
        );
      },
    )
  ],
);

class RoutesDocument {
  const RoutesDocument._();
  static const String camera = '/camera';
  static const String generate = '/generate';
  static const String settings = '/settings';
  static String qrDetails(String id) => '/camera/details/$id';
}
