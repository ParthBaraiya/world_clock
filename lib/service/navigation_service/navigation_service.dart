import 'package:flutter/material.dart';

import '../timezone.dart';
import 'world_clock_router_delegate.dart';

part 'no_transition_page.dart';
part 'route_arguments.dart';
part 'route_info_parser.dart';
part 'world_clock_path.dart';

class NavigationService {
  static final instance = NavigationService._();
  NavigationService._();

  final WorldClockRouterDelegate _delegate = WorldClockRouterDelegate();
  final WorldClockRouteInformationParser _informationParser =
      WorldClockRouteInformationParser();

  WorldClockRouterDelegate get delegate => _delegate;
  WorldClockRouteInformationParser get routeInformationParser =>
      _informationParser;

  GlobalKey<NavigatorState> get navigatorKey => _delegate.navigatorKey;

  void setPathConfig(WorldClockRouteConfig config) {
    _delegate.setRouteConfig(config);
  }
}

class RouteNames {
  RouteNames._();

  static const home = 'home';
  static const timezoneList = 'timezone-list';
  static const timezoneComparison = 'timezone-comparison';
  static const favorites = 'favorites';

  static const list = [
    home,
    timezoneList,
    timezoneComparison,
  ];
}
