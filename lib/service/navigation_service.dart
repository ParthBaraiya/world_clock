import 'package:flutter/material.dart';
import '../view/home.dart';
import '../view/timezone_list/timezone_list.dart';

class NavigationService {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Route getRoute({required Widget page}) => MaterialPageRoute(
          builder: (_) => page,
          settings: settings,
        );

    Route noRoute() => getRoute(
          page: Scaffold(
            body: Center(
              child: Text("No route defined for path: ${settings.name}"),
            ),
          ),
        );


    switch (settings.name) {
      case RouteNames.home:
        return getRoute(page: const HomePage());

      case RouteNames.timezoneList:
        return getRoute(page: const TimezoneList());

      default:
        return noRoute();
    }
  }
}

class RouteNames {
  RouteNames._();

  static const home = "/";
  static const timezoneList = "/list";
  static const timezoneComparizon = "/compare";
}
