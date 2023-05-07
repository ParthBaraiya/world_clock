part of 'navigation_service.dart';

class TimezonePath extends AppRouteConfig {
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

class InvalidPath extends AppRouteConfig {
  static const pathFragment = '/invalid';
  @override
  final String domain = pathFragment;
}

class HomePagePath extends AppRouteConfig {
  static const pathFragment = '/';

  @override
  final String domain = pathFragment;
}
