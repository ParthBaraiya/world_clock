import 'package:flutter/material.dart' hide MenuItem;

import '../../service/constants.dart';
import '../../service/extension.dart';
import '../../values/enums.dart';
import '../../values/world_clock_icons.dart';
import '../../widget/menu_item/menu_item.dart';

part 'backend/home_menu_bar_backend.dart';

class HomeMenuBar extends StatefulWidget {
  const HomeMenuBar({
    Key? key,
    required this.centerOffset,
  }) : super(key: key);

  final double centerOffset;

  @override
  State<HomeMenuBar> createState() => _HomeMenuBarState();
}

class _HomeMenuBarState extends State<HomeMenuBar> with HomeMenuBarBackend {
  @override
  Widget build(BuildContext context) {
    final children = [
      MenuItem(
        title: context.localizations.favorites,
        icon: WorldClockIcons.bookmark,
        onTap: _onFavorites,
        mode: mode,
      ),
      MenuItem(
        title: context.localizations.timezones,
        icon: WorldClockIcons.clock,
        onTap: _onTimezones,
        mode: mode,
      ),
      MenuItem(
        title: context.localizations.compare,
        icon: WorldClockIcons.exchange,
        onTap: _onCompare,
        mode: mode,
      ),
    ];

    return AnimatedPositioned(
      top: 0,
      left: widget.centerOffset,
      duration: Constants.defaultAnimationDuration,
      curve: Constants.curveGentle,
      child: AnimatedSize(
        duration: Constants.defaultAnimationDuration,
        reverseDuration: Constants.defaultAnimationDuration,
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.antiAlias,
        child: AnimatedCrossFade(
          duration: Constants.defaultAnimationDuration,
          alignment: Alignment.centerLeft,
          sizeCurve: Constants.curveGentle,
          crossFadeState: mode == WidgetMode.desktop
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Wrap(
            clipBehavior: Clip.hardEdge,
            alignment: WrapAlignment.start,
            direction: Axis.vertical,
            // mainAxisSize: MainAxisSize.min,
            children: children,
          ),
          secondChild: Wrap(
            clipBehavior: Clip.hardEdge,
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            // mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}
