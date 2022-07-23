import 'package:flutter/material.dart';

import '../values/world_clock_icons.dart';

class GithubThumb extends StatelessWidget {
  const GithubThumb({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: const CustomPaint(
        painter: _TrianglePainter(color: Color(0xff07002D)),
        child: Align(
          alignment: Alignment(0.6, -0.5),
          child: Icon(
            WorldClock.github_fill,
            size: 35,
          ),
        ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  const _TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final trianglePath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(trianglePath, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) => false;
}
