import 'service/timezone.dart';

typedef FavoriteChangeCallback = Future<void> Function(
    TimeZone location, bool selected);
