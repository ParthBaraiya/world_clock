part of 'home.dart';

class HomePageClock extends StatelessWidget {
  const HomePageClock({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < HomeScreenBreakPoints.point800;

    late final double clockSize;
    late final mainAxisSize;

    debugPrint(width.toString());

    if (isMobile) {
      clockSize = 250.0;
      mainAxisSize = MainAxisSize.min;
    } else {
      clockSize = math.min(350, width - 40);
      mainAxisSize = MainAxisSize.max;
    }

    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.instance.backgroundColor,
      ),
      constraints: BoxConstraints(maxWidth: width),
      child: Column(
        mainAxisSize: mainAxisSize,
        children: [
          const _HomePageAppBar(),
          Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Clock(
                  radius: clockSize,
                ),
              ),
              const SizedBox(height: 50),
              const TimeIndicator(),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  gradient: CustomTheme.instance.accentTextColor
                      .createSplitGradient(),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 50),
                      decoration: BoxDecoration(
                        color: CustomTheme.instance.backgroundColor,
                      ),
                      child: const TimeZoneInfo(),
                    ),
                    const SizedBox(
                      width: 1.5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: CustomTheme.instance.backgroundColor,
                      ),
                      child: const DayInfo(),
                    ),
                  ],
                ),
              ),
              if (isMobile)
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 10.0, top: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Favorites",
                          style: CustomTheme.instance.titleStyle,
                        ),
                        Container(
                          height: 1.5,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            gradient: LinearGradient(
                              colors: [
                                CustomTheme.instance.accentTextColor,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 7.0),
                        ),
                        // TODO: Add Favorites.
                        Row(
                          children: [
                            Opacity(
                              opacity: 1,
                              child: Text(
                                "Time 1",
                                style: CustomTheme.instance.heading5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class _HomePageAppBar extends StatelessWidget {
  const _HomePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < HomeScreenBreakPoints.point800;

    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 30.0, right: 10.0, bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "World Clock",
              style: CustomTheme.instance.titleStyle.copyWith(
                fontSize: isMobile ? 40 : 55,
              ),
              textAlign: isMobile ? TextAlign.start : TextAlign.center,
            ),
          ),
          if (isMobile) ...[
            InkWellButton(
              onTap: () => context.goToRoute(
                route: RouteNames.timezoneList,
              ),
              radius: BorderRadius.circular(100.0),
              hoverColor:
                  CustomTheme.instance.primaryTextColor.withOpacity(0.2),
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
              hoverColor:
                  CustomTheme.instance.primaryTextColor.withOpacity(0.2),
              child: Icon(
                WorldClock.exchange,
                size: 30,
                color: CustomTheme.instance.primaryTextColor,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
