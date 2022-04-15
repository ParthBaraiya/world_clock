part of 'home.dart';

class TimeZoneTab extends StatelessWidget {
  const TimeZoneTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          isScrollable: true,
          controller: controller,
          tabs: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text("Favorite"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text("All"),
            ),
          ],
          indicator: CustomTabIndicator(
              borderSide: BorderSide(
                  color: CustomTheme.instance.accentTextColor, width: 7)),
          indicatorSize: TabBarIndicatorSize.label,
        ),
        Expanded(
          child: TabBarView(controller: controller, children: [
            const Center(
              child: Text("Favorite"),
            ),
            const Center(
              child: Text("All"),
            ),
          ]),
        ),
      ],
    );
  }
}
