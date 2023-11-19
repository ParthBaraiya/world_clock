import 'package:flutter/material.dart';
import 'package:world_clock/app_services.dart';
import 'package:world_clock/service/navigation_service/navigation_service.dart';
import 'package:world_clock/service/theme/theme.dart';
import 'package:world_clock/widget/buttons.dart';
import 'package:world_clock/widget/decorations.dart';
import 'package:world_clock/widget/timezone_listing_widgets/all_timezones/all_timezone_list_widget.dart';
import 'package:world_clock/widget/timezone_listing_widgets/favorites_timezones/favorites_timezone_list_widget.dart';

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
    AppServices.navigationService.navigate(
        _tabController.index == 0 ? FavoritesPath.list() : TimezonePath.list());
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
            labelColor: CustomTheme.instance.accentTextColor,
            unselectedLabelColor:
                CustomTheme.instance.primaryTextColor.withOpacity(0.8),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            dividerHeight: 0,
            indicator: RoundedUnderlinedIndicator(
              borderSide: BorderSide(
                width: 5,
                color: CustomTheme.instance.accentTextColor,
              ),
              insets: const EdgeInsets.symmetric(horizontal: 30),
            ),
            tabs: [
              InkWellButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Favorite'),
                ),
                onTap: () => AppServices.navigationService
                    .navigate(FavoritesPath.list()),
              ),
              InkWellButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Timezones'),
                ),
                onTap: () =>
                    AppServices.navigationService.navigate(TimezonePath.list()),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              const FavoritesTimezonesListWidget(),
              const AllTimezonesListWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
