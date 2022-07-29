import 'package:flutter/material.dart' hide MenuItem;

import '../../service/extension.dart';
import '../../theme/theme.dart';
import '../../values/world_clock_icons.dart';
import '../../widget/clock/clock.dart';
import '../../widget/custom_scaffolds.dart';
import '../../widget/github_thumb.dart';
import '../../widget/menu_item/menu_item.dart';

part 'backend/home_backend.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeBackend {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localizations.worldClock,
                  style: theme.titleStyle.copyWith(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedClock(
                        radius: 400,
                        opacity: _clockOpacity,
                        offset: _clockOffset,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          direction: Axis.vertical,
                          spacing: 20,
                          children: [
                            MenuItem(
                              title: context.localizations.favorites,
                              icon: WorldClockIcons.bookmark,
                              onTap: _onFavorites,
                            ),
                            MenuItem(
                              title: context.localizations.timezones,
                              icon: WorldClockIcons.bookmark,
                              onTap: _onTimezones,
                            ),
                            MenuItem(
                              title: context.localizations.compare,
                              icon: WorldClockIcons.bookmark,
                              onTap: _onCompare,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: GithubThumb(
              size: 100,
            ),
          )
        ],
      ),
    );
  }
}
