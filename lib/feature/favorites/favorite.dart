import 'package:flutter/material.dart';

import '../../service/hive/hive_main.dart';
import '../../widget/location_tile/location_tile.dart';

part 'favorite_page.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveMain.instance.favoriteLocationsBox.watch(),
      builder: (_, snapshot) {
        final timezones =
            HiveMain.instance.favoriteLocationsBox.values.toList();

        debugPrint('${timezones.length}');
        return ListView.builder(
          itemBuilder: (_, index) {
            return LocationTile(
              key: ValueKey(timezones[index].timezone),
              timezone: timezones[index].timezone,
              selected: true,
            );
          },
          itemCount: timezones.length,
        );
      },
    );
  }
}
