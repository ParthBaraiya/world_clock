import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedUnderLinePainter extends CustomPainter {
  const AnimatedUnderLinePainter({
    required this.listenable,
    required this.lineColor,
    this.lineWidth = 4,
  }) : super(repaint: listenable);

  final ValueListenable<double> listenable;
  final double lineWidth;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTRB(0, size.height - lineWidth,
              size.width * listenable.value, size.height),
          Radius.circular(lineWidth)),
      Paint()..color = lineColor,
    );
  }

  @override
  bool shouldRepaint(covariant AnimatedUnderLinePainter oldDelegate) =>
      oldDelegate.listenable != listenable &&
      lineColor != oldDelegate.lineColor &&
      lineWidth != lineWidth;
}
