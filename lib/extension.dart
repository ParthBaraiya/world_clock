import 'dart:math' as math;

import 'package:flutter/material.dart';

extension ComparisonExtension on Size {
  double get max => math.max(width, height);

  double get min => math.min(width, height);

  Offset toOffset() => Offset(width, height);
}
