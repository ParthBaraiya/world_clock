part of 'test_navigation_service.dart';

class ClockTestPagePath extends AppRouteConfig {
  static const pathFragment = 'clock-test';

  @override
  final String domain = pathFragment;
}

class TestHomePagePath extends AppRouteConfig {
  static const pathFragment = '/';

  @override
  final String domain = pathFragment;
}

class TimeLineTestPath extends AppRouteConfig {
  static const pathFragment = 'time-line-test';

  @override
  final String domain = pathFragment;
}
