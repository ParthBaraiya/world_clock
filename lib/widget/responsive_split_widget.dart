import 'package:flutter/material.dart';

import '../service/extension.dart';
import '../service/theme/theme.dart';

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
    return _SplitScaffold(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: CustomTheme.instance.backgroundColor,
          ),
          child: left,
        ),
        const SizedBox(
          width: 1.5,
        ),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: CustomTheme.instance.backgroundColor,
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
    return Scaffold(
      key: key,
      backgroundColor: CustomTheme.instance.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: DecoratedBox(
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
}
