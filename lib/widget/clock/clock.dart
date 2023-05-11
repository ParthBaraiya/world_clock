import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../service/custom_ticker.dart';
import '../../service/extension.dart';
import '../../service/theme/theme.dart';
import '../../service/timezone.dart';

part 'painter.dart';

class Clock extends StatelessWidget {
  final double radius;
  final Location? location;

  const Clock({
    Key? key,
    required this.radius,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(radius),
      child: FittedBox(
        child: CustomPaint(
          size: Size.square(radius),
          willChange: true,
          painter: ClockMarkings(),
          foregroundPainter: ClockHands(
            location: location,
          ),
        ),
      ),
    );
  }
}