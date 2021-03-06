import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'service/hive/hive_main.dart';
import 'service/navigation_service/navigation_service.dart';
import 'service/shared_preferences.dart';
import 'service/theme/theme.dart';
import 'service/timezone.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());

  WidgetsFlutterBinding.ensureInitialized();

  await SPService.i.initialize();

  await HiveMain.instance.initialize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final mode = SPService.i.getThemeMode();

  CustomTheme.instance.initialize(mode == ThemeMode.system
      ? WidgetsBinding.instance.window.platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light
      : mode);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  TimeZoneUtility.i.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'World Clock',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: CustomTheme.instance.backgroundColor,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CustomTheme.instance.backgroundColor,
      ),
      scrollBehavior: const ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
        scrollbars: true,
      ),
      routerDelegate: NavigationService.instance.delegate,
      routeInformationParser: NavigationService.instance.routeInformationParser,
    );
  }
}
