import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/timezone.dart';

import '../../models/hive_location/hive_location.dart';
import '../../models/hive_timezone/hive_timezone.dart';
import '../extension.dart';
import '../world_clock_service.dart';

class HiveService extends WorldClockService<bool> {
  HiveService({
    required this.favoritesBox,
    required this.appLocationBox,
  }) : super(retries: 10);

  final String favoritesBox;
  final String appLocationBox;

  int _iteration = 0;

  final favoriteTimezonesBox = ValueNotifier<Box<HiveTimezone>?>(null);

  void initialize() {
    if (value != null) return;

    initializeService(() async {
      await Hive.initFlutter();

      Hive
        ..registerAdapter(HiveTimezoneAdapter())
        ..registerAdapter(HiveLocationAdapter());
      value = true;
      favoriteTimezonesBox.value =
          await Hive.openBox<HiveTimezone>(favoritesBox);
    });
  }

  Future<void> addFavoriteTimeZone(HiveTimezone location) async {
    final box = await _getFavoriteLocationBox();

    if (_locationIndex(box, location) == -1) {
      final result = await box.add(location);
      PrintUtility.debugLog(() => '$result');
      box.close();
    }
  }

  Future<void> removeFavoriteTimeZone(HiveTimezone location) async {
    final box = await _getFavoriteLocationBox();

    final index = _locationIndex(box, location);
    if (index != -1) {
      await box.deleteAt(index);
      box.close();
    }
  }

  Future<Location?> getCurrentLocation() async {
    final box = await _getCurrentLocationBox();
    Location? location;

    if (box.isNotEmpty) {
      location = box.get(0)?.location;
    }
    await box.close();

    return location;
  }

  Future<void> setCurrentLocation(Location location) async {
    final box = await _getCurrentLocationBox();

    await box.clear();
    await box.add(location.hiveLocation);
    await box.close();
  }

  int _locationIndex(Box<HiveTimezone> box, HiveTimezone location) {
    final locations = box.values.toList();
    final length = locations.length;

    for (var i = 0; i < length; i++) {
      if (locations[i] == location) return i;
    }

    return -1;
  }

  Future<Box<HiveTimezone>> _getFavoriteLocationBox() =>
      _getBox<HiveTimezone>(favoritesBox);

  Future<Box<HiveLocation>> _getCurrentLocationBox() =>
      _getBox<HiveLocation>(appLocationBox);

  Future<Box<T>> _getBox<T>(String name) async {
    if (await isInitialized && value != null) {
      _iteration = 0;
      return Hive.openBox<T>(name);
    } else {
      if (_iteration >= retries) {
        throw 'Hive box is not initialized.';
      }
      _iteration++;
      initialize();
      return _getBox(name);
    }
  }
}

class HiveBoxes {
  static const hiveLocationBoxID = 0;
  static const hiveTimeZoneBoxID = 1;
}
