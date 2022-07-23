import 'package:flutter/material.dart';

import '../values/world_clock_icons.dart';

class GithubThumb extends StatelessWidget {
  const GithubThumb({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Color(0xff07002D),
      ),
      child: Icon(WorldClock.github_fill),
    );
  }
}
