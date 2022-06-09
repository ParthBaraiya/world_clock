import 'service/timezone.dart';

typedef FavoriteChangeCallback = Future<bool> Function(
    TimeZone location, bool selected);
