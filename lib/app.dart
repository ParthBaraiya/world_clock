import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'app_services.dart';
import 'providers/current_location_provider.dart';
import 'service/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) async {
    //     final hive = AppServices.hive;
    //
    //     setLocation(
    //       // Set location from Hive
    //       await hive.getCurrentLocation() ??
    //
    //           // Ask user to set the location if no location is set in hive.
    //           await const LocationSelectorDialog().show() ??
    //
    //           // This is for fallback. If something unexpected happened then
    //           // set first location in the list.
    //           TimeZoneUtility.i.locations.first,
    //     );
    //   },
    // );
  }

  late Location _location = local;

  Future<void> setLocation(Location location) {
    _location = location;

    if (mounted) {
      setState(() {});
    }

    return AppServices.hive.setCurrentLocation(
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
        routerDelegate: AppServices.navigationService.delegate,
        routeInformationParser:
            AppServices.navigationService.routeInformationParser,
      ),
    );
  }
}
