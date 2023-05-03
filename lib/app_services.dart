import 'package:flutter/cupertino.dart';

import 'app.dart';
import 'service/hive/hive_main.dart';

class AppServices {
  //#region Static Fields
  static AppServices? _instance;

  static HiveService get hive => _instance!._hive;
  static GlobalKey<AppState> get app => _instance!._app;
  //#endregion

  late HiveService _hive;
  late GlobalKey<AppState> _app;

  AppServices._({
    required HiveService hive,
    required GlobalKey<AppState> app,
  })  : _hive = hive,
        _app = app;

  factory AppServices.init({
    required HiveService hive,
  }) =>
      _instance ??
      (_instance = AppServices._(
        hive: hive,
        app: GlobalKey<AppState>(),
      ));
}
