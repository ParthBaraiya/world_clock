import 'package:flutter/material.dart';

import 'app_route_config.dart';
import 'app_router_delegate.dart';

abstract class AppNavigationService {
  AppRouterDelegate get delegate;
  RouteInformationParser<AppRouteConfig> get routeInformationParser;

  GlobalKey<NavigatorState> get navigatorKey;

  NavigatorState? get navigator => navigatorKey.currentState;

  void navigate(AppRouteConfig config) => delegate.setRouteConfig(config);
}
