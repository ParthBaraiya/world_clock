part of 'navigation_service.dart';

@immutable
abstract class WorldClockRouteConfig {
  static const pathFragment = '';

  final String domain = pathFragment;

  String getPath() => domain;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorldClockRouteConfig && domain == other.domain;
}

class TimezonePath extends WorldClockRouteConfig {
  static const pathFragment = 'timezone';
  static const subPathFragment = 'list';

  @override
  final String domain = pathFragment;

  late final TimeZone? timezone;

  TimezonePath.list() : timezone = null;

  TimezonePath.details({required this.timezone});

  @override
  String getPath() {
    return '$domain/${timezone == null ? subPathFragment : timezone!.abbreviation}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimezonePath &&
          domain == other.domain &&
          timezone == other.timezone;
}

class FavoritesPath extends TimezonePath {
  static const pathFragment = 'favorite';
  static const subPathFragment = 'list';

  @override
  final String domain = pathFragment;

  FavoritesPath.list() : super.list();

  FavoritesPath.details({required TimeZone timezone})
      : super.details(timezone: timezone);
}

class InvalidPath extends WorldClockRouteConfig {
  static const pathFragment = '/invalid-url';
  @override
  final String domain = pathFragment;
}

class HomePagePath extends WorldClockRouteConfig {
  static const pathFragment = '/';

  @override
  final String domain = pathFragment;
}
