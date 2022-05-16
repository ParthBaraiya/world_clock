part of 'favorite.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final clockWidgetWidth = screenWidth < HomeScreenBreakPoints.point800
        ? screenWidth
        : screenWidth * 0.45;

    return ResponsiveSplitWidget(
      priority: ResponsiveSplitPriority.right,
      left: (_) => HomePageClock(
        width: clockWidgetWidth,
      ),
      right: (_) => const TimeZoneTab(index: 0),
    );
  }
}
