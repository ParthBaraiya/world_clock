part of 'home.dart';

enum TimezoneTabType {
  favorite,
  list,
}

class TimeZoneTab extends StatefulWidget {
  const TimeZoneTab({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<TimeZoneTab> createState() => _TimeZoneTabState();
}

class _TimeZoneTabState extends State<TimeZoneTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.index,
    );
    _tabController.addListener(_navigate);
  }

  @override
  void didUpdateWidget(TimeZoneTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    _tabController
      ..removeListener(_navigate)
      ..animateTo(widget.index)
      ..addListener(_navigate);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  void _navigate() {
    context.navigateTo(
        routeConfig: _tabController.index == 0
            ? FavoritesPath.list()
            : TimezonePath.list());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: RoundedUnderlinedIndicator(
              borderSide: BorderSide(
                width: 5,
                color: CustomTheme.instance.accentTextColor,
              ),
              insets: EdgeInsets.symmetric(horizontal: 30),
            ),
            tabs: [
              InkWellButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Favorite'),
                ),
                onTap: () => NavigationService.instance.delegate
                    .setRouteConfig(FavoritesPath.list()),
              ),
              InkWellButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Timezones'),
                ),
                onTap: () => NavigationService.instance.delegate
                    .setRouteConfig(TimezonePath.list()),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              const Favorites(),
              const TimezoneList(),
            ],
          ),
        ),
      ],
    );
  }
}
