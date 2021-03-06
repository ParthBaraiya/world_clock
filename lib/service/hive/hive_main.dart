import 'package:hive_flutter/adapters.dart';

import '../../models/hive_location/hive_location.dart';
import '../../models/hive_timezone/hive_timezone.dart';

class HiveMain {
  static final HiveMain instance = HiveMain._();

  HiveMain._();

  Future<void> initialize() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(HiveTimezoneAdapter())
      ..registerAdapter(HiveLocationAdapter());

    _favoriteLocationsBox = await Hive.openBox('favorites');
  }

  late Box<HiveTimezone> _favoriteLocationsBox;

  Box<HiveTimezone> get favoriteLocationsBox => _favoriteLocationsBox;

  void addFavorite(HiveTimezone location) {
    if (_locationIndex(location) != -1) _favoriteLocationsBox.add(location);
  }

  void removeFavorite(HiveTimezone location) {
    final index = _locationIndex(location);
    if (index != -1) {
      _favoriteLocationsBox.deleteAt(index);
    }
  }

  int _locationIndex(HiveTimezone location) {
    final locations = _favoriteLocationsBox.values.toList();
    final length = locations.length;

    for (var i = 0; i < length; i++) {
      if (locations[i] == location) return i;
    }

    return -1;
  }

  static const hiveLocationBoxID = 0;
  static const hiveTimeZoneBoxID = 1;
}
