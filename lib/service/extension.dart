import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'navigation_service/navigation_service.dart';

double get _screenHeight =>
    WidgetsBinding.instance.window.physicalSize.height /
    WidgetsBinding.instance.window.devicePixelRatio;
double get _screenWidth =>
    WidgetsBinding.instance.window.physicalSize.width /
    WidgetsBinding.instance.window.devicePixelRatio;

extension ComparisonExtension on Size {
  double get max => math.max(width, height);

  double get min => math.min(width, height);

  Offset toOffset() => Offset(width, height);
}

extension DateFormatExtension on DateTime {
  String get weekName => DateFormat('EEEE').format(this);
  String get dateMonth => DateFormat('d MMM').format(this);
  String get descriptiveDate => DateFormat('d MMMM yyyy').format(this);
}

extension NavigationExtension on BuildContext {
  void previousPage() => Navigator.of(this).pop();

  void navigateTo({
    required WorldClockRouteConfig routeConfig,
  }) =>
      NavigationService.instance.delegate.setRouteConfig(routeConfig);

  Size get mediaSize => MediaQuery.of(this).size;
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

extension ResponsiveSizesExtension on num {
  double get vh => _screenHeight * (this / 100);
  double get vw => _screenWidth * (this / 100);
}

extension PainterExtension on Canvas {
  void paintText({
    required String text,
    required TextStyle style,
    required Offset offset,
    required int minWidth,
    required int maxWidth,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout(
        minWidth: 10,
        maxWidth: 100,
      );

    painter.paint(this,
        offset - Offset(painter.maxIntrinsicWidth / 2, painter.height / 2));
  }
}

abstract class PrintUtility {
  static void debugLog(String Function() function) {
    assert(() {
      try {
        debugPrint(function());
      } catch (e) {} // Suppress exception...
      return true;
    }());
  }
}
