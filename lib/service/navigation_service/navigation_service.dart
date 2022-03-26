import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view/home.dart';
import '../../view/timezone_list/timezone_list.dart';

part 'route_arguments.dart';

class NavigationService {
  static final instance = NavigationService._();
  NavigationService._();

  final router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(
            name: RouteNames.timezoneList,
            path: 'timezones',
            builder: (_, __) => const TimezoneList(),
          ),
        ],
      ),
    ],
    errorBuilder: (_, state) {
      debugPrint(state.error.toString());
      return const Scaffold(
        body: Center(
          child: Text("No route defined for this url."),
        ),
      );
    },
  );

  RouterDelegate<Object> get delegate => router.routerDelegate;
  RouteInformationParser<Object> get routeInformationParser =>
      router.routeInformationParser;
}

class RouteNames {
  RouteNames._();

  static const home = "home";
  static const timezoneList = "timezone-list";
  static const timezoneComparison = "timezone-comparison";
}
