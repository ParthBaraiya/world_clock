import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../service/constants.dart';
import '../../service/extension.dart';
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
    return SizedBox.square(
      dimension: radius,
      child: FittedBox(
        child: CustomPaint(
          willChange: true,
          size: Size.square(radius),
          painter: ClockMarkings(),
          foregroundPainter: ClockHands(),
        ),
      ),
    );
  }
}

class AnimatedClock extends StatelessWidget {
  const AnimatedClock({
    Key? key,
    required this.radius,
    this.offset = Offset.zero,
    this.opacity = 1,
  }) : super(key: key);

  final double radius;
  final double opacity;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      curve: Constants.curveGentle,
      offset: offset,
      duration: Constants.duration800,
      child: AnimatedOpacity(
        opacity: opacity,
        curve: Constants.curveGentle,
        duration: Constants.duration800,
        child: Clock(
          radius: radius,
        ),
      ),
    );
  }
}
