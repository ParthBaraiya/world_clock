import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

// TODO: Use proper way to get the height and width data...
double get _screenHeight =>
    //ignore: deprecated_member_use
    WidgetsBinding.instance.window.physicalSize.height /
    //ignore: deprecated_member_use
    WidgetsBinding.instance.window.devicePixelRatio;
double get _screenWidth =>
    //ignore: deprecated_member_use
    WidgetsBinding.instance.window.physicalSize.width /
    //ignore: deprecated_member_use
    WidgetsBinding.instance.window.devicePixelRatio;

Brightness get platformBrightness =>
    PlatformDispatcher.instance.platformBrightness;

extension ComparisonExtension on Size {
  double get max => math.max(width, height);

  double get min => math.min(width, height);

  Offset toOffset() => Offset(width, height);

  Size copyWith({
    double? height,
    double? width,
  }) {
    return Size(
      width ?? this.width,
      height ?? this.height,
    );
  }
}

extension DateFormatExtension on DateTime {
  String get weekName => DateFormat('EEEE').format(this);
  String get dateMonth => DateFormat('d MMM').format(this);
  String get descriptiveDate => DateFormat('d MMMM yyyy').format(this);

  String format(String pattern) => DateFormat(pattern).format(this);
}

extension NavigationExtension on BuildContext {
  void previousPage() => Navigator.of(this).pop();

  Size get mediaSize => MediaQuery.sizeOf(this);
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

extension TimeZoneExtension on TimeZone {
  String get offsetInHour {
    final offset = this.offset / (1000 * 3600);

    return '${offset < 0 ? "-" : "+"}${offset.abs()}';
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
