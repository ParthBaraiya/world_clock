import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'app_services.dart';
import 'service/hive/hive_main.dart';
import 'service/shared_preferences.dart';
import 'service/theme/theme.dart';
import 'service/timezone.dart';
import 'service/universal_services/universal_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UniversalServices.i.setWebPathStrategy();

  // Initialize Shared Preferences.
  await SPService.i.initialize();

  AppServices.init(
    hive: HiveService(favoritesBox: 'favorites')..initialize(),
  );

  // Gets theme mode and set the theme data...
  final mode = SPService.i.getThemeMode();

  CustomTheme.instance.initialize(mode == ThemeMode.system
      ? WidgetsBinding.instance.window.platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light
      : mode);

  if (UniversalServices.i.isMobile) {
    // Set System UI overlay for Mobile devices.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // Initializes the timezone.
  await TimeZoneUtility.i.initialize();

  runApp(App(
    key: AppServices.app,
  ));
}
