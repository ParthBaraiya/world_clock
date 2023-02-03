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
      color: CustomTheme.instance.shadowColor,
    ).toPaint();

    canvas
      ..drawCircle(size.toOffset() / 2, radius, shadow)
      ..drawCircle(
        size.toOffset() / 2,
        radius,
        Paint()..color = CustomTheme.instance.clockBackground,
      )
      ..drawPoints(
        ui.PointMode.points,
        pointers.pointers,
        pointerPaint..color = CustomTheme.instance.primaryTextColor,
      )
      ..drawPoints(
        ui.PointMode.points,
        pointers.quarterPointers,
        pointerPaint..color = CustomTheme.instance.accentTextColor,
      );

    _drawNumbersPointer(radius, canvas);
  }

  void _drawNumbersPointer(double radius, Canvas canvas) {
    final style = TextStyle(
      fontSize: radius * 0.15,
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

      canvas.paintText(
        text: '$i',
        style: style,
        offset: offset,
        minWidth: 10,
        maxWidth: 200,
      );
    }
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
  // Passing timer will repaint this painter every second.
  ClockHands() : super(repaint: CustomTicker.secondTicker);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final radius = size.min / 2;

    final center = size.toOffset() / 2;

    final hourHeight = radius * 0.5;
    final minuteHeight = radius * 0.6;
    final secondHeight = radius * 0.82;


    final now = DateTime.now();

    final second = now.second;
    final minute = (now.minute * 60) + second;
    final hour = ((now.hour % 12) * 3600) + minute;

    final paint = Paint()..strokeCap = ui.StrokeCap.round;

    canvas
      ..drawLine(
        center,
        Offset(radius + (hourHeight * math.sin(hour * _hourAngle)),
            radius - (hourHeight * math.cos(hour * _hourAngle))),
        paint
          ..color = CustomTheme.instance.accentTextColor
          ..strokeWidth = radius * 0.045,
      )
      ..drawLine(
        center,
        Offset(radius + (minuteHeight * math.sin(minute * _minuteAngle)),
            radius - (minuteHeight * math.cos(minute * _minuteAngle))),
        paint
          ..color = CustomTheme.instance.primaryTextColor
          ..strokeWidth = radius * 0.03,
      )
      ..drawLine(
        center,
        Offset(radius + (secondHeight * math.sin(second * _secondAngle)),
            radius - (secondHeight * math.cos(second * _secondAngle))),
        paint
          ..color = CustomTheme.instance.primaryTextColor
          ..strokeWidth = radius * 0.02,
      )
      ..drawCircle(center, radius * 0.05,
          Paint()..color = CustomTheme.instance.accentTextColor);
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
