import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'service/hive/hive_main.dart';
import 'service/navigation_service/navigation_service.dart';
import 'service/shared_preferences.dart';
import 'service/timezone.dart';
import 'theme/theme.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());

  WidgetsFlutterBinding.ensureInitialized();

  await SPService.i.initialize();

  await HiveMain.instance.initialize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  TimeZoneUtility.i.initialize();

  runApp(const WorldClock());
}

class WorldClock extends StatefulWidget {
  const WorldClock({Key? key}) : super(key: key);

  @override
  State<WorldClock> createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  @override
  Widget build(BuildContext context) {
    return CustomThemeProvider(
      builder: (context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'World Clock',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: CustomTheme.of(context).backgroundColor,
        ),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: CustomTheme.of(context).backgroundColor,
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
        routeInformationParser:
            NavigationService.instance.routeInformationParser,
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
        ],
      ),
    );
  }
}
