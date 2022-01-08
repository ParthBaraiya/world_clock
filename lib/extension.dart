import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ComparisonExtension on Size {
  double get max => math.max(width, height);

  double get min => math.min(width, height);

  Offset toOffset() => Offset(width, height);
}

extension DateFormatExtension on DateTime {
  String get weekName => DateFormat("EEEE").format(this);
  String get dateMonth => DateFormat("d MMM").format(this);
}

extension NavigationExtension on BuildContext {
  Future<T?> pushNamed<T>({required String route, Object? argument}) =>
      Navigator.of(this).pushNamed<T>(route, arguments: argument);

  void pop() => Navigator.of(this).pop();
}
