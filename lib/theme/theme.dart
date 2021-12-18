import 'package:flutter/material.dart';

part 'theme_data.dart';

class CustomTheme extends ChangeNotifier {
  static final CustomTheme i = CustomTheme._();
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

  /// This function will have effect only once.
  void initialize(ThemeMode mode) {
    if (_initialized) return;

    _mode = mode;
    _data = mode == ThemeMode.light ? _LightThemeData() : _DarkThemeData();
    _initialized = true;
  }

  void updateThemeMode(ThemeMode mode) {
    if (_mode != mode) {
      _mode = mode;
      notifyListeners();
    }
  }
}
