import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedUnderlinedWidget extends StatefulWidget {
  const AnimatedUnderlinedWidget({
    super.key,
    required this.child,
    required this.underlineColor,
    this.onTap,
  });

  final Widget child;
  final ValueChanged? onTap;
  final Color underlineColor;

  @override
  State<AnimatedUnderlinedWidget> createState() =>
      _AnimatedUnderlinedWidgetState();
}

class _AnimatedUnderlinedWidgetState extends State<AnimatedUnderlinedWidget>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _controller.forward(),
      onExit: (event) => _controller.reverse(),
      cursor: SystemMouseCursors.click,
      child: CustomPaint(
        painter: _UnderlinePainter(
          color: widget.underlineColor,
          progress: _controller,
          radius: const Radius.circular(20),
        ),
        child: Padding(
          child: widget.child,
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
        ),
      ),
    );
  }
}

class _UnderlinePainter extends CustomPainter {
  final Color color;
  final double width;
  final double leftPadding;
  final double rightPadding;
  final ValueListenable<double> progress;
  final Radius radius;

  _UnderlinePainter({
    this.width = 4,
    this.leftPadding = 0,
    required this.color,
    this.rightPadding = 0,
    required this.progress,
    this.radius = Radius.zero,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final width = this.width.clamp(0, size.width);

    final right = size.width - rightPadding;
    final left = leftPadding.clamp(0.0, right);

    final rect = RRect.fromLTRBR(
      left,
      size.height - width,
      left + ((right - left) * progress.value),
      size.height,
      radius,
    );

    debugPrint("Rect: ${rect}");

    canvas.drawRRect(rect, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _UnderlinePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.rightPadding != rightPadding ||
      oldDelegate.leftPadding != leftPadding ||
      oldDelegate.width != width ||
      oldDelegate.progress != progress;
}
