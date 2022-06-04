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

  final _locations = <String, Location>{};

  Map<String, Location> get locations => _locations;

  TimeZone get utc => TimeZone.UTC;

  Future<void> initialize() async {
    initializeTimeZones();

    timeZoneDatabase.locations.forEach((key, value) {
      if (!(value.currentTimeZone.abbreviation[0] == '+' ||
          value.currentTimeZone.abbreviation[0] == '-')) {
        _locations.addAll({
          key: value,
        });
      }
    });

    initialized.value = true;
  }
}
