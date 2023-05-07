import 'package:flutter/material.dart';

import '../interfaces/navigation_utility_interface/app_navigation_service.dart';
import '../interfaces/navigation_utility_interface/app_route_config.dart';
import '../timezone.dart';
import 'world_clock_router_delegate.dart';

part 'no_transition_page.dart';
part 'route_arguments.dart';
part 'route_info_parser.dart';
part 'world_clock_path.dart';

class WorldClockNavigationService extends AppNavigationService {
  final WorldClockRouterDelegate _delegate =
      WorldClockRouterDelegate(initialPage: HomePagePath());
  final WorldClockRouteInformationParser _informationParser =
      WorldClockRouteInformationParser();

  @override
  WorldClockRouterDelegate get delegate => _delegate;

  @override
  WorldClockRouteInformationParser get routeInformationParser =>
      _informationParser;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _delegate.navigatorKey;
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
