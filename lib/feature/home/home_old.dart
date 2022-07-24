import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../service/extension.dart';
import '../../service/navigation_service/navigation_service.dart';
import '../../utils/decorations/rounded_underline_indicator.dart';
import '../../values/world_clock_icons.dart';
import '../../widget/buttons.dart';
import '../../widget/clock/clock.dart';
import '../../widget/day_info.dart';
import '../../widget/time_zone_info.dart';
import '../../widget/timer_indicator/timer_indicator.dart';
import '../favorites/favorite.dart';
import '../timezones/timezones.dart';

part 'home_page_clock.dart';
part 'tab_bar.dart';

class HomePageOld extends StatelessWidget {
  const HomePageOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _HomePageAppBar(),
        ],
      ),
    );
  }
}

class _HomePageAppBar extends StatelessWidget {
  const _HomePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 30.0, right: 10.0, bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'World Clock',
              style: theme.titleStyle.copyWith(
                fontSize: 40,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          InkWellButton(
            onTap: () => context.navigateTo(
              routeConfig: TimezonePath.list(),
            ),
            radius: BorderRadius.circular(100.0),
            hoverColor: theme.primaryTextColor.withOpacity(0.2),
            child: Icon(
              WorldClock.more,
              size: 30,
              color: theme.primaryTextColor,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWellButton(
            onTap: () {}, // TODO: Add callback
            radius: BorderRadius.circular(100.0),
            hoverColor: theme.primaryTextColor.withOpacity(0.2),
            child: Icon(
              WorldClock.exchange,
              size: 30,
              color: theme.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
