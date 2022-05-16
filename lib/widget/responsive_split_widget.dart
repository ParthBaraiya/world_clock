import 'package:flutter/material.dart';

import '../service/extension.dart';
import '../service/theme/theme.dart';

const _screenBreakPoint = 800.0;

enum ResponsiveSplitPriority {
  left,
  right,
}

class ResponsiveSplitWidget extends StatelessWidget {
  const ResponsiveSplitWidget({
    Key? key,
    this.breakPoint = _screenBreakPoint,
    required this.left,
    required this.right,
    this.priority = ResponsiveSplitPriority.left,
  }) : super(key: key);

  final WidgetBuilder left;
  final WidgetBuilder right;
  final double breakPoint;
  final ResponsiveSplitPriority priority;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return _ResponsiveSplitScaffold(
      children: [
        if (priority == ResponsiveSplitPriority.left) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              color: CustomTheme.instance.backgroundColor,
            ),
            child: left(context),
          ),
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
        ] else ...[
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
        ]
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
