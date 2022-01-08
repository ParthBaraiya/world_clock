import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? hoverColor;
  final EdgeInsets padding;
  final BorderRadius? radius;
  final Widget child;

  const InkWellButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.hoverColor,
    this.padding = EdgeInsets.zero,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      hoverColor: hoverColor,
      mouseCursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
