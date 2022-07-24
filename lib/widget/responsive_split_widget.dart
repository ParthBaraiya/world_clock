import 'package:flutter/material.dart';

import '../service/extension.dart';

class SplitWidget extends StatelessWidget {
  const SplitWidget({
    Key? key,
    required this.left,
    required this.right,
  }) : super(key: key);

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return _SplitScaffold(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.backgroundColor,
          ),
          child: left,
        ),
        const SizedBox(
          width: 1.5,
        ),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.backgroundColor,
            ),
            child: right,
          ),
        ),
      ],
    );
  }
}

class _SplitScaffold extends StatelessWidget {
  const _SplitScaffold({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      key: key,
      backgroundColor: theme.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient:
                theme.accentTextColor.createSplitGradient(bottom: 1, top: -1),
          ),
          child: Row(
            children: children,
          ),
        ),
      ),
    );
  }
}
