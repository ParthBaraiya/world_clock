import 'package:hive_flutter/adapters.dart';

import '../../models/hive_location/hive_location.dart';
import '../../models/hive_timezone/hive_timezone.dart';

class HiveMain {
  static final HiveMain instance = HiveMain._();

  HiveMain._();

  Future<void> initialize() async {
    await Hive.initFlutter();

    Hive..registerAdapter(HiveTimezoneAdapter())..registerAdapter(HiveLocationAdapter());
  }

  static const hiveLocationBoxID = 0;
  static const hiveTimeZoneBoxID = 1;
}
