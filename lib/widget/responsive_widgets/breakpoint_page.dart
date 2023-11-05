import 'package:flutter/material.dart';
import 'package:world_clock/service/extension.dart';

class TwoBreakPage extends StatelessWidget {
  const TwoBreakPage({
    Key? key,
    required this.point,
    required this.child1,
    required this.child2,
  }) : super(key: key);

  final double point;
  final Widget child1;
  final Widget child2;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.mediaSize.width;

    return screenWidth < point ? child2 : child1;
  }
}
