import 'package:flutter/material.dart';

abstract class AutoAnimateWidgetTween<T> {
  final T begin;
  final T end;
  final AutoAnimateWidgetTween? child;

  const AutoAnimateWidgetTween({
    required this.begin,
    required this.end,
    this.child,
  });

  Tween<T> get tween => Tween(begin: begin, end: end);

  @mustCallSuper
  Widget builder(BuildContext context, double value, Widget initialChild) {
    return child == null
        ? initialChild
        : child!.builder(context, value, initialChild);
  }
}

class AutoAnimateTranslateTween extends AutoAnimateWidgetTween<Offset> {
  const AutoAnimateTranslateTween({
    required super.begin,
    required super.end,
    super.child,
  });

  @override
  Widget builder(BuildContext context, double value, Widget initialChild) {
    final transformed = Transform.translate(
      offset: tween.transform(value),
      child: initialChild,
    );

    return super.builder(context, value, transformed);
  }
}

class AutoAnimateOpacityTween extends AutoAnimateWidgetTween<double> {
  const AutoAnimateOpacityTween({
    required super.begin,
    required super.end,
  });

  @override
  Widget builder(BuildContext context, double value, Widget initialChild) {
    final transparent = Opacity(
      // Here, clamp makes sure that opacity is always between 0 and 1.
      // Sometimes tween.transform can return value < 0 or > 1 depending on the
      // Curve.
      opacity: tween.transform(value).clamp(0, 1),
      child: initialChild,
    );

    return super.builder(context, value, transparent);
  }
}

class AutoAnimateScaleTween extends AutoAnimateWidgetTween<double> {
  const AutoAnimateScaleTween({
    required super.begin,
    required super.end,
    super.child,
  });

  @override
  Widget builder(BuildContext context, double value, Widget initialChild) {
    final transformed = Transform.scale(
      scale: tween.transform(value),
      child: initialChild,
    );

    return super.builder(context, value, transformed);
  }
}
