import 'package:hive/hive.dart';

import '../../service/hive/hive_main.dart';
import '../../service/timezone.dart';

part 'hive_timezone.g.dart';

@HiveType(typeId: HiveMain.hiveTimeZoneBoxID)
class HiveTimezone extends HiveObject {
  /// Milliseconds east of UTC.
  @HiveField(0)
  final int offset;

  /// Is this [TimeZone] Daylight Savings Time?
  @HiveField(1)
  final bool isDst;

  /// Abbreviated name, "CET".
  @HiveField(2)
  final String abbreviation;

  HiveTimezone({
    required this.offset,
    required this.isDst,
    required this.abbreviation,
  });

  TimeZone get timezone =>
      TimeZone(offset, isDst: isDst, abbreviation: abbreviation);

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      other is HiveTimezone &&
      offset == other.offset &&
      isDst == other.isDst &&
      abbreviation == other.abbreviation;
}

extension HiveExt on TimeZone {
  HiveTimezone get hiveTimezone => HiveTimezone(
        offset: offset,
        isDst: isDst,
        abbreviation: abbreviation,
      );
}
