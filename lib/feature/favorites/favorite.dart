import 'package:flutter/material.dart';
import 'package:world_clock/widget/timezone_listing_widgets/favorites_timezones/favorites_timezone_list_widget.dart';

import '../../app_services.dart';
import '../../models/hive_timezone/hive_timezone.dart';
import '../../service/theme/theme.dart';
import '../../widget/location_tile/location_tile.dart';

part 'favorite_page.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: AppServices.hive,
      builder: (_, value, child) {
        if (value ?? false) return child!;

        return const Text('Hive is not initialized.');
      },
      child: ValueListenableBuilder(
        valueListenable: AppServices.hive.favoriteTimezonesBox,
        builder: (_, value, __) {
          if (value == null) {
            return const Text('Loading favorites...');
          }
          return StreamBuilder(
            stream: value.watch(),
            builder: (_, __) {
              return TimeZoneTileList(
                timezones: value.values.toList(),
              );
            },
          );
        },
      ),
    );
  }
}

class TimeZoneTileList extends StatefulWidget {
  const TimeZoneTileList({
    super.key,
    required this.timezones,
  });

  final List<HiveTimezone> timezones;

  @override
  State<TimeZoneTileList> createState() => _TimeZoneTileListState();
}

class _TimeZoneTileListState extends State<TimeZoneTileList> {
  @override
  Widget build(BuildContext context) {
    if (widget.timezones.isEmpty) {
      return Center(
        child: Text(
          'No timezone found...',
          style: CustomTheme.instance.titleStyle,
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (_, index) {
        return TimezoneDetailsTile(
          key: ValueKey(widget.timezones[index].timezone),
          timezone: widget.timezones[index].timezone,
          selected: true,
        );
      },
      itemCount: widget.timezones.length,
    );
  }
}
