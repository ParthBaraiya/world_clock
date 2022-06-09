import 'dart:math' as math;

import 'package:flutter/material.dart';

// import 'package:go_router/go_router.dart';

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
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 30.0, right: 10.0, bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'World Clock',
              style: CustomTheme.instance.titleStyle.copyWith(
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
            hoverColor: CustomTheme.instance.primaryTextColor.withOpacity(0.2),
            child: Icon(
              WorldClock.more,
              size: 30,
              color: CustomTheme.instance.primaryTextColor,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWellButton(
            onTap: () {}, // TODO: Add callback
            radius: BorderRadius.circular(100.0),
            hoverColor: CustomTheme.instance.primaryTextColor.withOpacity(0.2),
            child: Icon(
              WorldClock.exchange,
              size: 30,
              color: CustomTheme.instance.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
