// TODO: Create a common mixin to implement the timeline list builder for
//  World Clock Future List Widget.

import 'package:flutter/cupertino.dart';
import 'package:world_clock/service/timezone.dart';
import 'package:world_clock/widget/location_tile/location_tile.dart';
import 'package:world_clock_widgets/widgets/world_clock_future_list_widget.dart';

abstract class TimeZoneListState<T extends StatefulWidget>
    extends WorldClockFutureListWidgetState<T, TimeZone> {
  @override
  Widget itemBuilder(BuildContext context, TimeZone item, int index) {
    return TimezoneDetailsTile(
      key: ValueKey(item),
      timezone: item,
      selected: isInFavorites(item, index),
    );
  }

  bool isInFavorites(TimeZone zone, int index);
}
