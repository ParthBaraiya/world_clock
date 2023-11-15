part of 'test_navigation_service.dart';

class TestRouteInformationParser
    extends RouteInformationParser<AppRouteConfig> {
  @override
  Future<AppRouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    final pathSegments = uri.pathSegments;
    debugPrint(pathSegments.toString());

    if (pathSegments.isEmpty) return TestHomePagePath();

    if (pathSegments.length < 3) {
      if (pathSegments[0] == ClockTestPagePath.pathFragment) {
        return ClockTestPagePath();
      } else if (pathSegments[0] == TimeLineTestPath.pathFragment) {
        return TimeLineTestPath();
      }
    }

    // Handle unknown routes
    return InvalidPath();
  }

  @override
  RouteInformation restoreRouteInformation(AppRouteConfig configuration) {
    return RouteInformation(uri: configuration.uri);
  }
}
