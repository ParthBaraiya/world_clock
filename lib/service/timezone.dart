import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/standalone.dart'
    if (dart.library.html) 'package:timezone/browser.dart';
import 'package:world_clock_widgets/utility/async_method_debouncer.dart';

export 'package:timezone/standalone.dart'
    if (dart.library.html) 'package:timezone/browser.dart';

class TimeZoneUtility {
  static final TimeZoneUtility i = TimeZoneUtility._();
  TimeZoneUtility._();

  // Gives the status whether timezone utility is initialized or not.
  @Deprecated('This is deprecated...')
  final ValueNotifier<bool> initialized = ValueNotifier(false);

  final _locationMap = <TimeZone, List<Location>>{};

  UnmodifiableMapView<TimeZone, List<Location>> get locationMap =>
      UnmodifiableMapView(_locationMap);

  UnmodifiableListView<Location> get locations =>
      UnmodifiableListView(timeZoneDatabase.locations.values);

  // TODO: Move this to state class...
  Iterable<Location> getFilteredLocations(String query) {
    if (query.isEmpty) return locations;

    final q = query.toLowerCase();

    return locations.where((element) {
      return element.name.toLowerCase().contains(q) ||
          element.currentTimeZone.abbreviation.toLowerCase().contains(q);
    });
  }

  late final _debouncer = AsyncMethodCallDebouncer(callback: _initialize);

  /// NOTE: Force variable is not functional yet.
  Future<void> initialize({bool force = false}) => _debouncer();

  Future<void> _initialize() async {
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
