part of 'home.dart';

enum TimezoneTabType {
  favorite,
  list,
}

class TimezonesPage extends StatelessWidget {
  final TimezoneTabType tabType;

  const TimezonesPage({
    Key? key,
    this.tabType = TimezoneTabType.favorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < HomeScreenBreakPoints.point800;

    return isMobile
        ? tabType == TimezoneTabType.favorite
            ? const FavoritesPage()
            : const TimezoneListPage()
        : SplitWidget(
            left: const HomePageClock(),
            right: TimeZoneTab(
              index: tabType.index,
            ),
          );
  }
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
    context.goNamed(_tabController.index == 0
        ? RouteNames.favorites
        : RouteNames.timezoneList);
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
            indicator: _CustomUnderlinedIndicator(
              borderSide: BorderSide(
                width: 5,
                color: CustomTheme.instance.accentTextColor,
              ),
            ),
            tabs: [
              InkWellButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Favorite'),
                ),
                onTap: () {
                  if (widget.index == 0) return;
                  _tabController.animateTo(0);
                },
              ),
              InkWellButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Timezones'),
                ),
                onTap: () {
                  if (widget.index == 1) return;
                  _tabController.animateTo(1);
                },
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
