import 'package:flutter/material.dart';

class RoundedUnderlinedIndicator extends Decoration {
  const RoundedUnderlinedIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
  });

  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is RoundedUnderlinedIndicator) {
      return RoundedUnderlinedIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is RoundedUnderlinedIndicator) {
      return RoundedUnderlinedIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
      indicator.left,
      indicator.bottom - borderSide.width,
      indicator.width,
      borderSide.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final RoundedUnderlinedIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final textDirection = configuration.textDirection!;
    final indicator = decoration
        ._indicatorRectFor(rect, textDirection)
        .deflate(decoration.borderSide.width / 2.0);
    final paint = decoration.borderSide.toPaint()..strokeCap = StrokeCap.round;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
    // canvas.drawRect(rect, paint);
  }
}
