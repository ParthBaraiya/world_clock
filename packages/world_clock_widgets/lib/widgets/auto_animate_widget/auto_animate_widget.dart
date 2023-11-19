import 'package:flutter/material.dart';
import 'package:world_clock_widgets/widgets/auto_animate_widget/auto_animate_tweens.dart';

class AutoAnimatedWidget extends StatefulWidget {
  const AutoAnimatedWidget({
    super.key,
    required this.child,
    required this.tween,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.ease,
  });

  final AutoAnimateWidgetTween tween;
  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<AutoAnimatedWidget> createState() => _AutoAnimatedWidgetState();
}

class _AutoAnimatedWidgetState extends State<AutoAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    reverseDuration: widget.duration,
    value: 0,
  );

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return widget.tween.builder(
          context,
          _animation.value,
          child!,
        );
      },
      child: widget.child,
    );
  }
}
