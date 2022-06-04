import 'package:hive/hive.dart';

import '../../service/hive/hive_main.dart';
import '../../service/timezone.dart';
import '../hive_timezone/hive_timezone.dart';

part 'hive_location.g.dart';

@HiveType(typeId: HiveMain.hiveLocationBoxID)
class HiveLocation extends HiveObject {
  /// [Location] name.
  @HiveField(0)
  final String name;

  /// Transition time, in milliseconds since 1970 UTC.
  @HiveField(1)
  final List<int> transitionAt;

  /// The index of the zone that goes into effect at that time.
  @HiveField(2)
  final List<int> transitionZone;

  /// [TimeZone]s at this [Location].
  @HiveField(3)
  final List<HiveTimezone> zones;

  HiveLocation({
    required this.name,
    required this.transitionAt,
    required this.transitionZone,
    required this.zones,
  });

  Location get location {
    final timezones = <TimeZone>[];

    final length = zones.length;

    for (var i = 0; i < length; i++) {
      timezones.add(zones[i].timezone);
    }

    return Location(name, transitionAt, transitionZone, timezones);
  }
}

extension HiveExt on Location {
  HiveLocation get hiveLocation {
    final timezones = <HiveTimezone>[];
    final length = zones.length;

    for (var i = 0; i < length; i++) {
      timezones.add(zones[i].hiveTimezone);
    }

    return HiveLocation(
      name: name,
      transitionAt: transitionAt,
      transitionZone: transitionZone,
      zones: timezones,
    );
  }
}
