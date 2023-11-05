import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:world_clock/service/extension.dart';

import '../service/theme/theme.dart';
import '../widget/clock/clock.dart';

class ClockTest extends StatefulWidget {
  const ClockTest({super.key});

  @override
  State<ClockTest> createState() => _ClockTestState();
}

class _ClockTestState extends State<ClockTest> {
  late var _maxRadius =
      math.min(context.mediaSize.width - 40, context.mediaSize.height - 40);
  late var _minRadius = math.min(_maxRadius - 1, 100.0);

  late double _radius = _maxRadius;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _maxRadius =
        math.min(context.mediaSize.width - 40, context.mediaSize.height - 40);

    _minRadius = math.min(_maxRadius - 1, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SizedBox(
              height: _radius,
              width: _radius,
              child: FittedBox(
                child: Clock(
                  radius: _radius,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: context.mediaSize.height * 0.02,
            left: context.mediaSize.width * 0.3,
            right: context.mediaSize.width * 0.3,
            child: Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _radius,
                    onChanged: (value) {
                      _radius = value;
                      if (context.mounted) {
                        setState(() {});
                      }
                    },
                    min: _minRadius,
                    max: _maxRadius,
                  ),
                ),
                const SizedBox(width: 30),
                Text(
                  _radius.toStringAsFixed(1),
                  style: CustomTheme.instance.subtitleStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
