import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  static final SPService i = SPService._();

  SPService._();

  bool _initialized = false;

  late SharedPreferences preferences;

  final String themeKey = "SP_THEME";

  Future<void> initialize() async {
    if (_initialized) return;

    preferences = await SharedPreferences.getInstance();
    _initialized = true;
  }

  Future<void> setTheme(ThemeMode mode) async =>
      preferences.setString(themeKey, mode.toString());

  ThemeMode getThemeMode() {
    final mode = preferences.getString(themeKey);

    switch (mode) {
      case "ThemeMode.dark":
        return ThemeMode.dark;
      case "ThemeMode.light":
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
