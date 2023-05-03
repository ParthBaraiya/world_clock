import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'app_services.dart';
import 'providers/current_location_provider.dart';
import 'service/navigation_service/navigation_service.dart';
import 'service/theme/theme.dart';
import 'service/timezone.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    final hive = AppServices.hive;
    hive.getCurrentLocation().then((value) {
      if (value == null) {
        showDialog(
          context:
              NavigationService.instance.navigatorKey.currentState!.context,
          barrierDismissible: true,
          barrierColor: Colors.black26,
          // TODO: Add route settings...
          // routeSettings: ,
          builder: (_) {
            return const Dialog(
              child: Text('No locations are saved...'),
            );
          },
        ).then((value) {
          final location = TimeZoneUtility.i.locationMap.values.first.first;
          setLocation(location);
        });
      } else {
        final location = TimeZoneUtility.i.locationMap.values.first.first;
        setLocation(location);
      }
    });
  }

  late Location _location = local;

  void setLocation(Location location) {
    _location = location;

    if (mounted) {
      setState(() {});
    }

    AppServices.hive.setCurrentLocation(
      location,
    );
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
