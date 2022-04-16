part of 'home.dart';

class TimeZoneTab extends StatelessWidget {
  const TimeZoneTab({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
      tabs: [
        InkWellButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text("Favorite"),
          ),
          onTap: () {
            if (index == 0) return;
            context.pushNamed(RouteNames.favorites);
          },
        ),
        InkWellButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text("Timezones"),
          ),
          onTap: () {
            if (index == 1) return;
            context.pushNamed(RouteNames.timezoneList);
          },
        ),
      ],
      pages: [
        const Center(
          child: Text("Favorite"),
        ),
        const TimezoneList(),
      ],
      selectedIndex: index,
    );
  }
}
