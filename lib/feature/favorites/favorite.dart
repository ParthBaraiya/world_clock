import 'package:flutter/material.dart';

import '../../models/hive_timezone/hive_timezone.dart';
import '../../service/hive/hive_main.dart';
import '../../widget/location_tile/location_tile.dart';
import '../../widget/location_tile/location_tile_expansion_settings.dart';

part 'favorite_page.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveMain.instance.favoriteLocationsBox.watch(),
      builder: (_, snapshot) {
      
        return _LocationTileList(
          timezones: HiveMain.instance.favoriteLocationsBox.values.toList(),
        );
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
