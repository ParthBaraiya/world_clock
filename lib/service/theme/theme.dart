import 'package:flutter/material.dart';

import '../shared_preferences.dart';

part 'theme_data.dart';

class CustomTheme extends ChangeNotifier {
  static final CustomTheme instance = CustomTheme._();

  CustomTheme._();

  bool _initialized = false;

  ThemeMode _mode = ThemeMode.light;
  _ThemeData _data = _LightThemeData();

  ThemeMode get mode => _mode;

  Color get backgroundColor => _data.backgroundColor;

  Color get clockBackground => _data.clockBackground;

  Color get primaryTextColor => _data.primaryTextColor;

  Color get accentTextColor => _data.accentTextColor;

  Color get shadowColor => _data.shadowColor;

  TextStyle get titleStyle => _data.titleStyle;

  TextStyle get subtitleStyle => _data.subtitleStyle;

  TextStyle get heading5 => _data.heading5;
  TextStyle get heading6 => _data.heading6;

  TextStyle get timezoneTitleStyle => _data.timezoneTitleStyle;
  TextStyle get timezoneSubTitleStyle => _data.timezoneSubTitleStyle;

  TextStyle get timezoneTitleAccentStyle => _data.timezoneTitleAccentStyle;
  TextStyle get timezoneSubTitleAccentStyle =>
      _data.timezoneSubTitleAccentStyle;

  /// This function will have effect only once.
  void initialize(ThemeMode mode) {
    if (_initialized) return;

    _mode = mode;
    _data = mode == ThemeMode.light ? _LightThemeData() : _DarkThemeData();
    _initialized = true;
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    if (_mode != mode) {
      await SPService.i.setTheme(mode);
      _mode = mode;
      notifyListeners();
    }
  }
}
