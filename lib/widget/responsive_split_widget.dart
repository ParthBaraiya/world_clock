import 'package:flutter/material.dart';

import '../service/extension.dart';
import '../service/theme/theme.dart';

const _screenBreakPoint = 800.0;

class ResponsiveSplitLeftWidget extends StatelessWidget {
  const ResponsiveSplitLeftWidget({
    Key? key,
    this.breakPoint = _screenBreakPoint,
    required this.left,
    required this.right,
  }) : super(key: key);

  final WidgetBuilder left;
  final WidgetBuilder right;
  final double breakPoint;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return _ResponsiveSplitScaffold(
      children: [
        left(context),
        if (screenWidth > breakPoint) ...[
          const SizedBox(
            width: 1.5,
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: CustomTheme.instance.backgroundColor,
              ),
              child: right(context),
            ),
          ),
        ],
      ],
    );
  }
}

class ResponsiveSplitRightWidget extends StatelessWidget {
  const ResponsiveSplitRightWidget({
    Key? key,
    this.breakPoint = _screenBreakPoint,
    required this.left,
    required this.right,
  }) : super(key: key);

  final WidgetBuilder left;
  final WidgetBuilder right;
  final double breakPoint;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return _ResponsiveSplitScaffold(
      children: [
        if (screenWidth > breakPoint) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              color: CustomTheme.instance.backgroundColor,
            ),
            child: left(context),
          ),
          const SizedBox(
            width: 1.5,
          ),
        ],
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: CustomTheme.instance.backgroundColor,
            ),
            child: right(context),
          ),
        ),
      ],
    );
  }
}

class _ResponsiveSplitScaffold extends Scaffold {
  _ResponsiveSplitScaffold({
    Key? key,
    required List<Widget> children,
  }) : super(
          key: key,
          backgroundColor: CustomTheme.instance.backgroundColor,
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomTheme.instance.accentTextColor
                    .createSplitGradient(bottom: 1, top: -1),
              ),
              child: Row(
                children: children,
              ),
            ),
          ),
        );
}
