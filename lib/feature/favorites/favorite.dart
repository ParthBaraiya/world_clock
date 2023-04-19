import 'package:flutter/material.dart';

import '../../app_services.dart';
import '../../models/hive_timezone/hive_timezone.dart';
import '../../service/theme/theme.dart';
import '../../widget/location_tile/location_tile.dart';
import '../../widget/location_tile/location_tile_expansion_settings.dart';

part 'favorite_page.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppServices.hive,
      builder: (_, value, __) {
        if (value != null) {
          return StreamBuilder(
            stream: value.watch(),
            builder: (_, __) {
              return _LocationTileList(
                timezones: value.values.toList(),
              );
            },
          );
        }
        return const Text('Hive is not initialized.');
      },
    );
  }
}

class _LocationTileList extends StatefulWidget {
  const _LocationTileList({
    super.key,
    required this.timezones,
  });

  final List<HiveTimezone> timezones;

  @override
  State<_LocationTileList> createState() => _LocationTileListState();
}

class _LocationTileListState extends State<_LocationTileList>
    with LocationTileExpansionSettingsMixin {
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
    return LocationTileExpansionSettings(
      child: ListView.builder(
        itemBuilder: (_, index) {
          return LocationTile(
            key: ValueKey(widget.timezones[index].timezone),
            timezone: widget.timezones[index].timezone,
            selected: true,
          );
        },
        itemCount: widget.timezones.length,
      ),
      shrinkedZones: shrinkedZones,
      onExpand: onExpand,
      onShrink: onShrink,
    );
  }
}
