import 'package:flutter/material.dart';
import 'package:world_clock/service/extension.dart';

class TimeLineTest extends StatefulWidget {
  const TimeLineTest({super.key});

  @override
  State<TimeLineTest> createState() => _TimeLineTestState();
}

class _TimeLineTestState extends State<TimeLineTest> {
  final _offset = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: double.maxFinite,
          child: Listener(
            onPointerMove: (event) {
              _offset.value += event.delta.dx.toInt();
            },
            child: CustomPaint(
              painter: CustomPainterDemo(
                offset: _offset,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPainterDemo extends CustomPainter {
  final ValueNotifier<int> offset; // Defines minute offset.

  /// This will have no effect for now.
  final int offsetPerMinute;

  final int sectionSize;

  CustomPainterDemo({
    required this.offset,
    this.offsetPerMinute = 2,
    this.sectionSize = 15,
  })  : assert(offsetPerMinute > 0),
        assert(sectionSize < 60 && 60 % sectionSize == 0.0),
        super(repaint: offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..clipRect(Offset.zero & size)
      ..drawColor(Colors.red, BlendMode.screen);

    /// Range of time that will be covered in current size of custom painter.
    final start = offset.value * 0 - (size.width / (2 * offsetPerMinute));
    final end = offset.value * 0 + (size.width / (2 * offsetPerMinute));

    // offset from where we need to start drawing...
    final sOffset = (sectionSize * offsetPerMinute) -
        ((start % (sectionSize * offsetPerMinute)) + offsetPerMinute);

    final lineHeight = size.height * 0.6;
    final lineWidth = 2.0;

    final numberStyle = const TextStyle(
      fontSize: 15,
      color: Colors.white,
    );

    for (var i = sOffset.toDouble();
        i < size.width;
        i += (15 * offsetPerMinute)) {
      canvas.drawLine(
        Offset(i, size.height),
        Offset(i, lineHeight),
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidth
          ..strokeCap = StrokeCap.round,
      );

      final text = '${(i ~/ offsetPerMinute) % 60}';
      final top = size.height * 0.5;
      canvas.paintText(
        text: text == '0' && i != 1440 ? '12' : text,
        minWidth: 2,
        maxWidth: 300,
        offset: Offset(i, top - 12),
        style: numberStyle,
      );
    }

    // final sOffset = canvas
    //   ..drawColor(Colors.red, BlendMode.screen)
    //   ..paintText(
    //     text: '${offset.value}',
    //     style: const TextStyle(
    //       color: Colors.amber.withOpacity(0.5),
    //       fontSize: 30,
    //     ),
    //     offset: Offset(size.width / 2, size.height / 2),
    //     maxWidth: 2000,
    //     minWidth: 100,
    //   );
  }

  @override
  bool shouldRepaint(covariant CustomPainterDemo oldDelegate) => true;
}
