part of 'home.dart';

class HomePageClock extends StatelessWidget {
  const HomePageClock({
    Key? key,
    this.showTitle = true,
  }) : super(key: key);

  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final width = screenWidth *
        (screenWidth < HomeScreenBreakPoints.point800 ? 0.6 : 0.45);

    final clockSize = (width - 40).clamp(200, 500).toDouble();

    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.instance.backgroundColor,
      ),
      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Opacity(
              opacity: showTitle ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 30.0, right: 10.0, bottom: 50.0),
                child: Text(
                  'World Clock',
                  style: CustomTheme.instance.titleStyle.copyWith(
                    fontSize: 55,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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
                gradient:
                    CustomTheme.instance.accentTextColor.createSplitGradient(),
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
            )
          ],
        ),
      ),
    );
  }
}
