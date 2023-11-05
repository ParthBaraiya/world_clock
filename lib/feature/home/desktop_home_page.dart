import 'package:flutter/material.dart';
import 'package:world_clock/feature/home/home_page_clock.dart';
import 'package:world_clock/feature/home/tab_bar.dart';

import '../../service/extension.dart';
import '../../service/theme/theme.dart';
import '../../values/breakpoints.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({
    super.key,
    required this.index,
    required this.widget,
  });

  final int index;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    late final widget;
    if (size.width < HomeScreenBreakPoints.point800) {
      widget = this.widget;
    } else {
      const dividerWidth = 1.5;
      final media = MediaQuery.of(context);
      final width = media.size.width - dividerWidth;

      final section1 = width * 0.45;
      final section2 = width - section1;

      widget = SafeArea(
        child: Row(
          children: [
            MediaQuery(
              data: media.copyWith(
                size: media.size.copyWith(width: section1),
              ),
              child: SizedBox.fromSize(
                size: media.size.copyWith(width: section1),
                child: const HomePageClock(),
              ),
            ),
            VerticalDivider(
              color: theme.accentTextColor.withOpacity(0.4),
              indent: media.size.height * 0.1,
              endIndent: media.size.height * 0.1,
            ),
            Expanded(
              child: MediaQuery(
                data: media.copyWith(
                  size: Size(section2, media.size.height),
                ),
                child: SizedBox.fromSize(
                  size: Size(section2, media.size.height),
                  child: ColoredBox(
                    color: CustomTheme.instance.backgroundColor,
                    child: TimeZoneTab(
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: CustomTheme.instance.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: widget,
    );
  }
}
