import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:world_clock/tests/time_line_test.dart';

import '../../../../feature/error_404.dart';
import '../../../../service/interfaces/navigation_utility_interface/app_navigation_service.dart';
import '../../../../service/interfaces/navigation_utility_interface/app_route_config.dart';
import '../../../../service/interfaces/navigation_utility_interface/app_router_delegate.dart';
import '../../../../service/navigation_service/navigation_service.dart';
import '../../../clock_test.dart';
import '../../../test_home.dart';

part 'test_path.dart';
part 'test_router_delegate.dart';
part 'text_route_info_parser.dart';

class TestNavigationService extends AppNavigationService {
  // TODO: Create a home page and use that as initial page...
  final TextRouterDelegate _delegate =
      TextRouterDelegate(initialPage: TestHomePagePath());
  final TestRouteInformationParser _informationParser =
      TestRouteInformationParser();

  @override
  TextRouterDelegate get delegate => _delegate;

  @override
  TestRouteInformationParser get routeInformationParser => _informationParser;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _delegate.navigatorKey;
}

class TestRouteNames {
  TestRouteNames._();

  static const clockTest = 'clock-test';
}
