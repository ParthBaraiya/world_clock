part of 'clock.dart';

const double _secondAngle = 0.10472;
const double _minuteAngle = 0.001745;
const double _hourAngle = 0.00014542;

class ClockMarkings extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final minimum = size.min;
    final radius = minimum / 2;

    final markerSize = minimum * 0.025;

    final pointerPaint = Paint()
      ..strokeWidth = markerSize
      ..strokeCap = StrokeCap.round;
    final pointers = _getPointerOffsets(radius);

    final shadow = BoxShadow(
      blurRadius: 35,
      offset: const Offset(4, 4),
      color: CustomTheme.i.shadowColor,
    ).toPaint();

    canvas
      ..drawCircle(size.toOffset() / 2, radius, shadow)
      ..drawCircle(
        size.toOffset() / 2,
        radius,
        Paint()..color = CustomTheme.i.clockBackground,
      )
      ..drawPoints(
        ui.PointMode.points,
        pointers.pointers,
        pointerPaint..color = CustomTheme.i.primaryTextColor,
      )
      ..drawPoints(
        ui.PointMode.points,
        pointers.quarterPointers,
        pointerPaint..color = CustomTheme.i.accentTextColor,
      );

    _drawNumbersPointer(radius, canvas);
  }

  void _drawNumbersPointer(double radius, Canvas canvas) {
    final style = TextStyle(
      fontSize: radius * 0.1,
      color: Colors.white,
    );

    final offsets = _getPointerOffsets(radius, 0.77);

    for (var i = 1; i < 13; i++) {
      late final Offset offset;
      if (i % 3 == 0) {
        offset = offsets.quarterPointers[(i ~/ 3) - 1];
      } else {
        offset = offsets.pointers[i - (i ~/ 3) - 1];
      }

      final painter = _getTextPainter(number: i, style: style);

      painter.paint(canvas,
          offset - Offset(painter.maxIntrinsicWidth / 2, painter.height / 2));
    }
  }

  TextPainter _getTextPainter({required int number, required TextStyle style}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$number',
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 10,
        maxWidth: 30,
      );

    return textPainter;
  }

  ClockPointers _getPointerOffsets(double radius, [double factor = 0.9]) {
    final effectiveRadius = radius * factor;

    return ClockPointers(quarterPointers: [
      Offset(effectiveRadius + radius, radius),
      Offset(radius, radius + effectiveRadius),
      Offset(radius - effectiveRadius, radius),
      Offset(radius, radius - effectiveRadius),
    ], pointers: [
      Offset(
        radius + (0.5 * effectiveRadius),
        radius + (-0.866 * effectiveRadius),
      ),
      Offset(
        radius + (0.866 * effectiveRadius),
        radius + (-0.5 * effectiveRadius),
      ),
      Offset(
        radius + (0.866 * effectiveRadius),
        radius + (0.5 * effectiveRadius),
      ),
      Offset(
        radius + (0.5 * effectiveRadius),
        radius + (0.866 * effectiveRadius),
      ),
      Offset(
        radius + (-0.5 * effectiveRadius),
        radius + (0.866 * effectiveRadius),
      ),
      Offset(
        radius + (-0.866 * effectiveRadius),
        radius + (0.5 * effectiveRadius),
      ),
      Offset(
        radius + (-0.866 * effectiveRadius),
        radius + (-0.5 * effectiveRadius),
      ),
      Offset(
        radius + (-0.5 * effectiveRadius),
        radius + (-0.866 * effectiveRadius),
      ),
    ]);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ClockHands extends CustomPainter {
  // Parsing timer will repaint this painter every second.
  ClockHands() : super(repaint: ClockTimer.timer);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final radius = size.min / 2;

    final center = size.toOffset() / 2;

    final hourHeight = radius * 0.4;
    final minuteHeight = radius * 0.5;
    final secondHeight = radius * 0.63;

    final second = ClockTimer.timer.second;
    final minute = (ClockTimer.timer.minute * 60) + second;
    final hour = ((ClockTimer.timer.hour % 12) * 3600) + minute;

    final paint = Paint()..strokeCap = ui.StrokeCap.round;

    canvas
      ..drawLine(
        center,
        Offset(radius + (hourHeight * math.sin(hour * _hourAngle)),
            radius - (hourHeight * math.cos(hour * _hourAngle))),
        paint
          ..color = CustomTheme.i.accentTextColor
          ..strokeWidth = radius * 0.033,
      )
      ..drawLine(
        center,
        Offset(radius + (minuteHeight * math.sin(minute * _minuteAngle)),
            radius - (minuteHeight * math.cos(minute * _minuteAngle))),
        paint
          ..color = CustomTheme.i.primaryTextColor
          ..strokeWidth = radius * 0.021,
      )
      ..drawLine(
        center,
        Offset(radius + (secondHeight * math.sin(second * _secondAngle)),
            radius - (secondHeight * math.cos(second * _secondAngle))),
        paint
          ..color = CustomTheme.i.primaryTextColor
          ..strokeWidth = radius * 0.01,
      )
      ..drawCircle(center, radius * 0.05,
          Paint()..color = CustomTheme.i.accentTextColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ClockPointers {
  final List<Offset> quarterPointers;
  final List<Offset> pointers;

  ClockPointers({
    required this.quarterPointers,
    required this.pointers,
  });
}
