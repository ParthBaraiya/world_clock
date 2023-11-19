import 'package:flutter/material.dart';
import 'package:world_clock/providers/current_location_provider.dart';
import 'package:world_clock/service/constants.dart';
import 'package:world_clock/service/extension.dart';
import 'package:world_clock/service/theme/theme.dart';
import 'package:world_clock/service/timezone.dart';
import 'package:world_clock/values/world_clock_icons.dart';
import 'package:world_clock/widget/clock/clock.dart';
import 'package:world_clock_widgets/widgets/animated_underlined_widget.dart';
import 'package:world_clock_widgets/widgets/auto_animate_widget/auto_animate_tweens.dart';
import 'package:world_clock_widgets/widgets/auto_animate_widget/auto_animate_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(42, 0, 255, 0),
              Color.fromRGBO(42, 0, 255, 0.13),
            ],
            stops: [.6, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _TimeDetails(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.065,
                  ),
                  child: AutoAnimatedWidget(
                    curve: Constants.defaultAnimationCurve,
                    duration: const Duration(seconds: 1),
                    tween: const AutoAnimateTranslateTween(
                      begin: Offset(0, 150.0),
                      end: Offset.zero,
                      child: AutoAnimateOpacityTween(
                        begin: 0.2,
                        end: 1,
                      ),
                    ),
                    child: Clock(
                      radius: MediaQuery.sizeOf(context).width * 0.2,
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _Menu(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _TimeDetails extends StatelessWidget {
  const _TimeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final location = CurrentLocationProvider.of(context).location;
    final time = TZDateTime.now(location);
    final timezone = location.currentTimeZone;

    return AutoAnimatedWidget(
      duration: const Duration(seconds: 1),
      curve: Constants.defaultAnimationCurve,
      tween: const AutoAnimateTranslateTween(
        begin: Offset(-70.0, 0.0),
        end: Offset.zero,
        child: AutoAnimateOpacityTween(
          begin: 0.4,
          end: 1,
        ),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${time.format(
                WorldClockDateFormats.hhMM,
              )} ',
              style: CustomTheme.instance.titleStyle.copyWith(
                fontSize: 55,
              ),
            ),
            TextSpan(
              text: '${time.format(
                WorldClockDateFormats.a,
              )}\n',
              style: CustomTheme.instance.heading5,
            ),
            TextSpan(
              text: '${time.format(
                WorldClockDateFormats.weekDay,
              )}\n',
              style: CustomTheme.instance.heading5,
            ),
            TextSpan(
              text: '${time.format(
                WorldClockDateFormats.dateMonth,
              )}\n\n',
              style: CustomTheme.instance.heading5,
            ),
            TextSpan(
              text: '${timezone.abbreviation.toUpperCase()}\n',
              style: CustomTheme.instance.timezoneTitleAccentStyle.copyWith(
                fontSize: 40,
              ),
            ),
            TextSpan(
              text: 'UTC ${timezone.offsetInHour} HRS\n\n',
              style: CustomTheme.instance.heading5,
            ),
            TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.location_pin,
                    color: CustomTheme.instance.accentTextColor,
                    size: 30,
                  ),
                ),
                TextSpan(
                  text: '  ${location.name}',
                  style: CustomTheme.instance.heading5,
                ),
              ],
            )
          ],
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoAnimatedWidget(
      duration: const Duration(seconds: 1),
      curve: Constants.defaultAnimationCurve,
      tween: const AutoAnimateTranslateTween(
        begin: Offset(70.0, 0.0),
        end: Offset.zero,
        child: AutoAnimateOpacityTween(
          begin: 0.4,
          end: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomePageMenuItem(
            title: 'Favorites',
            leading: Icons.bookmark,
          ),
          const HomePageMenuItem(
            title: 'Timezones',
            leading: WorldClockIcons.more,
          ),
          const HomePageMenuItem(
            title: 'Compare',
            leading: WorldClockIcons.exchange,
          ),
          HomePageMenuItem(
            title: 'Github',
            leading: WorldClockIcons.github,
            onTap: 'https://github.com/ParthBaraiya/world_clock'.uri.launch,
          ),
        ],
      ),
    );
  }
}

class HomePageMenuItem extends StatelessWidget {
  const HomePageMenuItem({
    super.key,
    required this.leading,
    required this.title,
    this.onTap,
  });

  final IconData leading;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Icon(
                leading,
                size: 38,
              ),
            ),
            const SizedBox(width: 20),
            AnimatedUnderlinedWidget(
              child: Text(
                title,
                style: CustomTheme.instance.heading4,
              ),
              underlineColor: CustomTheme.instance.accentTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
