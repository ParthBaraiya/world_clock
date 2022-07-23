import 'package:flutter/material.dart';

import '../service/extension.dart';
import '../service/theme/theme.dart';
import '../values/breakpoints.dart';
import 'home/home.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({
    super.key,
    required this.index,
    required this.widget,
  });
  final int index;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    late final widget;
    if (size.width < HomeScreenBreakPoints.point800) {
      widget = this.widget;
    } else {
      const dividerWidth = 1.5;

      final media = MediaQuery.of(context);

      final width = media.size.width - dividerWidth;

      final section1 = width * 0.45;
      final section2 = width - section1;

      widget = DecoratedBox(
        decoration: BoxDecoration(
          gradient: CustomTheme.instance.accentTextColor
              .createSplitGradient(bottom: 1, top: -1),
        ),
        child: SafeArea(
          child: Row(
            children: [
              MediaQuery(
                data: media.copyWith(
                  size: Size(section1, media.size.height),
                ),
                child: SizedBox.fromSize(
                  size: Size(section1, media.size.height),
                  child: ColoredBox(
                    color: CustomTheme.instance.backgroundColor,
                    child: const HomePageClock(),
                  ),
                ),
              ),
              const SizedBox(
                width: 1.5,
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
