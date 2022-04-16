import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.pages,
    required this.selectedIndex,
    this.indicatorSettings = const IndicatorSettings(),
  }) : super(key: key);

  final List<Widget> tabs;
  final List<Widget> pages;
  final int selectedIndex;
  final IndicatorSettings indicatorSettings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: tabs._buildTabs(
              settings: indicatorSettings,
              context: context,
              selectedIndex: selectedIndex,
            ),
          ),
        ),
        Expanded(
          child: pages[selectedIndex],
        ),
      ],
    );
  }
}

extension _WidgetList on List<Widget> {
  List<Widget> _buildTabs({
    required BuildContext context,
    required int selectedIndex,
    required IndicatorSettings settings,
  }) {
    final widgets = <Widget>[];
    final length = this.length;
    for (var i = 0; i < length; i++) {
      final child = Padding(
        padding: EdgeInsets.only(bottom: settings.width),
        child: this[i],
      );

      widgets.add(
        i == selectedIndex
            ? CustomPaint(
                painter: _IndicatorPainter(
                  settings: settings,
                ),
                child: child,
              )
            : child,
      );
    }

    return widgets;
  }
}

class _IndicatorPainter extends CustomPainter {
  const _IndicatorPainter({
    required this.settings,
  });

  final IndicatorSettings settings;

  @override
  void paint(Canvas canvas, Size size) {
    final left = settings.leftOffset > size.width ? 0.0 : settings.leftOffset;
    final right = size.width -
        (settings.rightOffset > size.width ? 0.0 : settings.rightOffset);

    final rRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(left, size.height - settings.width, right, size.height),
        settings.radius);
    canvas.drawRRect(rRect, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

@immutable
class IndicatorSettings {
  final double width;
  final Color color;
  final Radius radius;
  final double leftOffset;
  final double rightOffset;

  const IndicatorSettings({
    this.width = 1,
    this.color = Colors.transparent,
    this.radius = Radius.zero,
    this.leftOffset = 0,
    this.rightOffset = 0,
  });

  @override
  bool operator ==(Object other) =>
      other is IndicatorSettings &&
      other.rightOffset == rightOffset &&
      other.leftOffset == leftOffset &&
      other.width == width &&
      other.color == color &&
      other.radius == radius;

  @override
  int get hashCode => super.hashCode;
}
