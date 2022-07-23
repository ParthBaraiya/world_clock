import 'package:flutter/material.dart';

import '../values/breakpoints.dart';
import '../widget/responsive_split_widget.dart';
import '../widget/responsive_widgets/breakpoint_page.dart';
import 'home/home.dart';

class ResponsiveHomePage extends TwoBreakPage {
  ResponsiveHomePage({
    Key? key,
    required Widget mobilePage,
    required int index,
  }) : super(
          key: key,
          point: HomeScreenBreakPoints.point800,
          child1: SplitWidget(
            left: const HomePageClock(),
            right: TimeZoneTab(
              index: index,
            ),
          ),
          child2: mobilePage,
        );
}
