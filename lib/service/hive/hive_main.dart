import 'package:hive_flutter/adapters.dart';

import '../../models/hive_location/hive_location.dart';
import '../../models/hive_timezone/hive_timezone.dart';
import '../extension.dart';
import '../world_clock_service.dart';

class HiveService extends WorldClockService<Box<HiveTimezone>> {
  HiveService({
    required this.favoritesBox,
  }) : super(retries: 10);

  final String favoritesBox;

  int _iteration = 0;

  void initialize() {
    if (value != null) return;

    initializeService(() async {
      await Hive.initFlutter();

      Hive
        ..registerAdapter(HiveTimezoneAdapter())
        ..registerAdapter(HiveLocationAdapter());

      value = await Hive.openBox(favoritesBox);
    });
  }

  Future<Box<HiveTimezone>> get _favoriteLocationsBoxAsync =>
      _getFavoriteLocationBox();

  Future<Box<HiveTimezone>> _getFavoriteLocationBox() async {
    if (await isInitialized && value != null) {
      _iteration = 0;
      return value!;
    } else {
      if (_iteration >= retries) {
        throw 'Hive box is not initialized.';
      }
      _iteration++;
      initialize();
      return _getFavoriteLocationBox();
    }
  }

  Future<void> addFavoriteTimeZone(HiveTimezone location) async {
    final box = await _favoriteLocationsBoxAsync;

    if (_locationIndex(box, location) == -1) {
      final result = await box.add(location);
      PrintUtility.debugLog(() => '$result');
    }
  }

  Future<void> removeFavoriteTimeZone(HiveTimezone location) async {
    final box = await _favoriteLocationsBoxAsync;

    final index = _locationIndex(box, location);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  int _locationIndex(Box<HiveTimezone> box, HiveTimezone location) {
    final locations = box.values.toList();
    final length = locations.length;

    for (var i = 0; i < length; i++) {
      if (locations[i] == location) return i;
    }

    return -1;
  }
}

class HiveBoxes {
  static const hiveLocationBoxID = 0;
  static const hiveTimeZoneBoxID = 1;
}
