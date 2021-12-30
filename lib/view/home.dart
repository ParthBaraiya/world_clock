import 'package:flutter/material.dart';

import '../clock/clock.dart';
import '../font_icon/world_clock_icons.dart';
import '../theme/theme.dart';
import '../widget/day_info.dart';
import '../widget/time_zone_info.dart';
import '../widget/timer_indictor.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.i.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 30.0, right: 10.0, bottom: 50.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "World Clock",
                      style: CustomTheme.i.titleStyle,
                    ),
                  ),
                  const Icon(
                    WorldClock.more,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    WorldClock.exchange,
                    size: 30,
                  ),
                ],
              ),
            ),
            const Clock(
              radius: 250,
            ),
            const SizedBox(
              height: 50,
            ),
            const TimeIndicator(),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    CustomTheme.i.accentTextColor,
                    Colors.transparent,
                  ],
                  begin: const Alignment(0, -1.7),
                  end: const Alignment(0, 1.7),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 50),
                    decoration: BoxDecoration(
                      color: CustomTheme.i.backgroundColor,
                    ),
                    child: const TimeZoneInfo(),
                  ),
                  const SizedBox(
                    width: 1.5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    decoration: BoxDecoration(
                      color: CustomTheme.i.backgroundColor,
                    ),
                    child: const DayInfo(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 10.0, top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Favorites",
                      style: CustomTheme.i.titleStyle,
                    ),
                    Container(
                      height: 1.5,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        gradient: LinearGradient(
                          colors: [
                            CustomTheme.i.accentTextColor,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 7.0),
                    ),
                    // TODO: Add Favorites.
                    Row(
                      children: [
                        const Opacity(
                          opacity: 0,
                          child: Text("Time 1"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        Colors.transparent,
        CustomTheme.i.accentTextColor,
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        Paint()..shader = gradient.createShader(Offset.zero & size));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
