import 'package:timezone/data/latest_all.dart';
import "package:timezone/standalone.dart"
    if (dart.library.html) "package:timezone/browser.dart";

export 'package:timezone/standalone.dart'
    if (dart.library.html) "package:timezone/browser.dart";

class TimeZoneUtility {
  static final TimeZoneUtility i = TimeZoneUtility._();

  TimeZoneUtility._();

  bool _initialized = false;

  bool get initialized => _initialized;

  Map<String, Location> _locations = {};

  Map<String, Location> get locations => _locations;

  TimeZone get utc => TimeZone.UTC;

  Future<void> initialize() async {
    initializeTimeZones();
    _locations = timeZoneDatabase.locations;
    _initialized = true;
  }
}
