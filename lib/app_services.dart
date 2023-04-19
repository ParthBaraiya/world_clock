import 'service/hive/hive_main.dart';

class AppServices {
  static AppServices? _instance;

  HiveService? _hive;

  static HiveService get hive => _instance!._hive!;

  AppServices._({
    required HiveService hive,
  }) : _hive = hive;

  factory AppServices.init({
    required HiveService hive,
  }) =>
      _instance ?? (_instance = AppServices._(hive: hive));
}
