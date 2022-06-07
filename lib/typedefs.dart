import 'service/timezone.dart';

typedef FavoriteChangeCallback = Future<bool> Function(
    Location location, bool selected);
