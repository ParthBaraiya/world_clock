import 'package:flutter/material.dart';

class AnimatedLinePainter extends CustomPainter {
  final Animation<double> listenable;
  final Color lineColor;
  AnimatedLinePainter({required this.listenable, required this.lineColor})
      : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    final lineWidth = size.width * listenable.value;
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    final top = size.height - 4;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, top, lineWidth, size.height),
      const Radius.circular(20),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedLinePainter oldDelegate) =>
      listenable != oldDelegate.listenable;
}
