import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../service/extension.dart';
import '../../service/navigation_service/navigation_service.dart';
import '../../service/theme/theme.dart';
import '../../values/breakpoints.dart';
import '../../values/world_clock_icons.dart';
import '../../widget/buttons.dart';
import '../../widget/clock/clock.dart';
import '../../widget/day_info.dart';
import '../../widget/responsive_split_widget.dart';
import '../../widget/time_zone_info.dart';
import '../../widget/timer_indicator.dart';
import '../favorites/favorite.dart';
import '../timezones/timezones.dart';

part 'custom_indicator.dart';
part 'home_page_clock.dart';
part 'tab_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final clockWidgetWidth = screenWidth < HomeScreenBreakPoints.point800
        ? screenWidth
        : screenWidth * 0.45;

    return ResponsiveSplitWidget(
      left: (_) => HomePageClock(
        width: clockWidgetWidth,
      ),
      right: (_) => const TimeZoneTab(index: 0),
    );
  }
}
