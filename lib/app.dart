import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'app_services.dart';
import 'providers/current_location_provider.dart';
import 'service/navigation_service/navigation_service.dart';
import 'service/theme/theme.dart';
import 'service/timezone.dart';
import 'values/world_clock_icons.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final hive = AppServices.hive;

      final location = await hive.getCurrentLocation();

      if (location == null) {
        showDialog(
          context:
              NavigationService.instance.navigatorKey.currentState!.context,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          // TODO: Move this to router delegate...
          routeSettings: const RouteSettings(name: 'selectLocationDialog'),
          builder: (_) {
            final locations = TimeZoneUtility.i.locations;

            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    final width = math.min(900.0, constraints.maxWidth * 0.85);
                    final padding = width * 0.05;

                    return SizedBox(
                      width: width,
                      height: constraints.maxHeight * 0.9,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: CustomTheme.instance.clockBackground,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: CustomTheme.instance.backgroundColor,
                                blurRadius: 10,
                                offset: const Offset(4, 4),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: padding,
                            left: padding,
                            bottom: padding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Location',
                                style: CustomTheme.instance.titleStyle,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 2,
                                width: double.infinity,
                                child: ColoredBox(
                                  color: CustomTheme.instance.accentTextColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    WorldClockIcons.search,
                                    color:
                                        CustomTheme.instance.primaryTextColor,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        hintText: 'Search location',
                                        hintStyle:
                                            CustomTheme.instance.subtitleStyle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: locations.length,
                                  physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  itemBuilder: (_, index) {
                                    final location = locations[index];
                                    final timezone = location.currentTimeZone;

                                    return InkWell(
                                      onTap: () {
                                        setLocation(location);
                                        NavigationService
                                            .instance.navigatorKey.currentState
                                            ?.pop();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${location.name} - ',
                                              style:
                                                  CustomTheme.instance.heading4,
                                            ),
                                            Text(
                                              timezone.abbreviation,
                                              style: CustomTheme
                                                  .instance.heading4
                                                  .copyWith(
                                                color: CustomTheme.instance
                                                    .subtitleStyle.color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      } else {
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
