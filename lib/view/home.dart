import 'package:flutter/material.dart';
import 'package:world_clock/widget/timer_indictor.dart';
import '../clock/clock.dart';
import '../font_icon/world_clock_icons.dart';
import '../theme/theme.dart';

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
          ],
        ),
      ),
    );
  }
}
