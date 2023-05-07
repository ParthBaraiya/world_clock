import 'package:flutter/cupertino.dart';

import 'app.dart';
import 'service/hive/hive_main.dart';
import 'service/interfaces/navigation_utility_interface/app_navigation_service.dart';

class AppServices {
  //#region Static Fields
  static AppServices? _instance;

  static HiveService get hive => _instance!._hive;
  static GlobalKey<AppState> get app => _instance!._app;
  static AppNavigationService get navigationService => _instance!._navigator;
  //#endregion

  late HiveService _hive;
  late GlobalKey<AppState> _app;
  late AppNavigationService _navigator;

  AppServices._({
    required HiveService hive,
    required GlobalKey<AppState> app,
    required AppNavigationService navigator,
  })  : _hive = hive,
        _app = app,
        _navigator = navigator;

  factory AppServices.init({
    required HiveService hive,
    required AppNavigationService navigator,
  }) =>
      _instance ??
      (_instance = AppServices._(
        hive: hive,
        app: GlobalKey<AppState>(),
        navigator: navigator,
      ));
}
