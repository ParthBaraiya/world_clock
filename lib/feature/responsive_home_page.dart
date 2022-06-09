import 'package:flutter/material.dart';

import '../values/breakpoints.dart';
import '../widget/responsive_split_widget.dart';
import 'home/home.dart';

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({
    Key? key,
    required this.mobilePage,
    required this.index,
  }) : super(key: key);

  final Widget mobilePage;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < HomeScreenBreakPoints.point800;

    return isMobile
        ? mobilePage
        : SplitWidget(
            left: const HomePageClock(),
            right: TimeZoneTab(index: index),
          );
  }
}
