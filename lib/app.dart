import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'providers/current_location_provider.dart';
import 'service/navigation_service/navigation_service.dart';
import 'service/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  late Location _location = local;

  void setLocation(Location location) {
    _location = location;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurrentLocationProvider(
      location: _location,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'World Clock',
        // TODO: Set this data from theme...
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
        routeInformationParser:
            NavigationService.instance.routeInformationParser,
      ),
    );
  }
}
