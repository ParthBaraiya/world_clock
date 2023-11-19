import 'package:flutter/material.dart';
import 'package:world_clock/feature/home_old/home_page_clock.dart';

// import 'package:go_router/go_router.dart';

import '../../app_services.dart';
import '../../service/navigation_service/navigation_service.dart';
import '../../service/theme/theme.dart';
import '../../values/world_clock_icons.dart';
import '../../widget/buttons.dart';

class HomePageOld extends StatelessWidget {
  /// Defines home page for all type of devices...
  /// i.e. Mobile, Web and Desktop
  ///
  const HomePageOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          _HomePageAppBar(),
          Expanded(
            child: HomePageClock(
              showTitle: false,
            ),
          ),
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
            onTap: () => AppServices.navigationService.navigate(
              TimezonePath.list(),
            ),
            radius: BorderRadius.circular(100.0),
            hoverColor: CustomTheme.instance.primaryTextColor.withOpacity(0.2),
            child: Icon(
              WorldClockIcons.more,
              size: 30,
              color: CustomTheme.instance.primaryTextColor,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWellButton(
            onTap: () => AppServices.navigationService.navigate(
              FavoritesPath.list(),
            ),
            radius: BorderRadius.circular(100.0),
            hoverColor: CustomTheme.instance.primaryTextColor.withOpacity(0.2),
            child: Icon(
              Icons.bookmark_outline,
              size: 30,
              color: CustomTheme.instance.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
