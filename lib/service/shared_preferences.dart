import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  static final SPService i = SPService._();

  SPService._();

  late SharedPreferences preferences;

  final String themeKey = "SP_THEME";

  Future<void> initialize() async {
    preferences = await SharedPreferences.getInstance();
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
