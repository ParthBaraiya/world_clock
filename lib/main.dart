import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'service/navigation_service/navigation_service.dart';
import 'service/shared_preferences.dart';
import 'service/theme/theme.dart';
import 'service/timezone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SPService.i.initialize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final mode = SPService.i.getThemeMode();

  CustomTheme.i.initialize(mode == ThemeMode.system
      ? WidgetsBinding.instance?.window.platformBrightness == Brightness.dark
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
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerDelegate: NavigationService.instance.delegate,
      routeInformationParser: NavigationService.instance.routeInformationParser,
    );
  }
}
