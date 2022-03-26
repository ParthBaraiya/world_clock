import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../extension.dart';
import '../../service/theme/theme.dart';
import '../../service/timer.dart';

part 'painter.dart';

class Clock extends StatelessWidget {
  final double radius;

  const Clock({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(radius),
      child: CustomPaint(
        painter: ClockMarkings(),
        foregroundPainter: ClockHands(),
      ),
    );
  }
}
