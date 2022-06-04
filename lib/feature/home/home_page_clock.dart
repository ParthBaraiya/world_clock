part of 'home.dart';

class HomePageClock extends StatelessWidget {
  const HomePageClock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    late final double clockSize;

    final width = screenWidth * 0.45;

    debugPrint(width.toString());

    clockSize = math.min(350, width - 40);

    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.instance.backgroundColor,
      ),
      constraints: BoxConstraints(maxWidth: width),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 30.0, right: 10.0, bottom: 50.0),
              child: Align(
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
