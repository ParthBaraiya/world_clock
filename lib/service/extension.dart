import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/theme.dart';
import 'navigation_service/navigation_service.dart';

extension ComparisonExtension on Size {
  double get max => math.max(width, height);

  double get min => math.min(width, height);

  Offset toOffset() => Offset(width, height);
}

extension DateFormatExtension on DateTime {
  String get weekName => DateFormat('EEEE').format(this);
  String get dateMonth => DateFormat('d MMM').format(this);
}

extension NavigationExtension on BuildContext {
  void previousPage() => Navigator.of(this).pop();

  void navigateTo({
    required WorldClockRouteConfig routeConfig,
  }) =>
      NavigationService.instance.delegate.setRouteConfig(routeConfig);
}

extension SplitGradient on Color {
  LinearGradient createSplitGradient({
    double top = -1.7,
    double bottom = 1.7,
  }) =>
      LinearGradient(
        colors: [
          Colors.transparent,
          this,
          Colors.transparent,
        ],
        begin: Alignment(0, top),
        end: Alignment(0, bottom),
      );
}

extension ThemeExtension on BuildContext {
  CustomThemeData get theme => CustomTheme.of(this);

  void setThemeMode(ThemeMode mode) {
    CustomThemeProvider.globalKey.currentState?.updateThemeMode(mode);
  }
}
