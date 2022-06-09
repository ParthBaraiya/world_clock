import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/standalone.dart'
    if (dart.library.html) 'package:timezone/browser.dart';

export 'package:timezone/standalone.dart'
    if (dart.library.html) 'package:timezone/browser.dart';

class TimeZoneUtility {
  static final TimeZoneUtility i = TimeZoneUtility._();

  TimeZoneUtility._();

  // Gives the status whether timezone utility is initialized or not.
  final ValueNotifier<bool> initialized = ValueNotifier(false);

  final _locationMap = <TimeZone, List<Location>>{};

  Map<TimeZone, List<Location>> get locationMap => _locationMap;

  TimeZone get utc => TimeZone.UTC;

  Future<void> initialize() async {
    initializeTimeZones();

    final locations = timeZoneDatabase.locations.values.toList();
    final length = locations.length;

    for (var i = 0; i < length; i++) {
      final location = locations[i];
      final timezone = location.currentTimeZone;

      if (_locationMap[timezone] == null) {
        _locationMap.addAll({
          timezone: [location],
        });
      } else {
        _locationMap[timezone]!.add(location);
      }
    }

    initialized.value = true;
  }
}
