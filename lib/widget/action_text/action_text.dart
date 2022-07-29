import 'package:flutter/material.dart';

import '../../service/constants.dart';
import '../../service/extension.dart';
import '../../theme/theme.dart';
import '../../utils/painters/animated_underline_painter.dart';

class ActionText extends StatefulWidget {
  const ActionText({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  State<ActionText> createState() => _ActionTextState();
}

class _ActionTextState extends State<ActionText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  late CustomThemeData theme;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      duration: Constants.defaultAnimationDuration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = context.theme;
  }

  @override
  void dispose() {
    _animation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _animation,
      builder: (_, value, child) {
        return CustomPaint(
          child: child,
          painter: AnimatedUnderLinePainter(
            listenable: _animation,
            lineColor: theme.accentTextColor,
          ),
        );
      },
      child: TextButton(
        onPressed: widget.onTap,
        onHover: (isHover) {
          if (isHover)
            _animation.forward();
          else
            _animation.reverse();
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 22,
            color: theme.accentTextColor,
          ),
        ),
      ),
    );
  }
}
