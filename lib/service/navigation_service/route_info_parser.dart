part of 'navigation_service.dart';

class WorldClockRouteInformationParser
    extends RouteInformationParser<AppRouteConfig> {
  @override
  Future<AppRouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    final pathSegments = uri.pathSegments;
    debugPrint(pathSegments.toString());

    if (pathSegments.isEmpty) return HomePagePath();

    if (pathSegments.length < 3) {
      if (pathSegments[0] == FavoritesPath.pathFragment) {
        final timezone = getTimezoneFromAbbr(pathSegments[1]);
        if (timezone == null) {
          return FavoritesPath.list();
        } else {
          return FavoritesPath.details(timezone: timezone);
        }
      } else if (pathSegments[0] == TimezonePath.pathFragment) {
        final timezone = getTimezoneFromAbbr(pathSegments[1]);
        if (timezone == null) {
          debugPrint('Timezone list path...');
          return TimezonePath.list();
        } else {
          return TimezonePath.details(timezone: timezone);
        }
      }
    }

    // Handle unknown routes
    return InvalidPath();
  }

  @override
  RouteInformation restoreRouteInformation(AppRouteConfig configuration) {
    return RouteInformation(location: configuration.getPath());
  }

  TimeZone? getTimezoneFromAbbr(String? abbr) {
    if (abbr == null || abbr.isEmpty) return null;

    final timezones = TimeZoneUtility.i.locationMap.keys.toList();
    final length = timezones.length;

    for (var i = 0; i < length; i++) {
      final timezone = timezones[i];
      if (abbr == timezone.abbreviation) {
        return timezone;
      }
    }

    return null;
  }
}
