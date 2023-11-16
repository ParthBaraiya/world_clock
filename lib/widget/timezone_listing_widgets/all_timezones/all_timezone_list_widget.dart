import 'dart:async';

import 'package:flutter/material.dart';
import 'package:world_clock/service/timezone.dart';
import 'package:world_clock/widget/timezone_listing_widgets/timezone_listing_with_filters.dart';

class AllTimezonesListWidget extends StatefulWidget {
  const AllTimezonesListWidget({super.key});

  @override
  State<AllTimezonesListWidget> createState() => _AllTimezonesListWidgetState();
}

class _AllTimezonesListWidgetState = TimezoneListingWithFiltersWidgetState<
    AllTimezonesListWidget> with _AllTimeZonesWidgetDataProvider;

mixin _AllTimeZonesWidgetDataProvider
    on TimezoneListingWithFiltersWidgetState<AllTimezonesListWidget> {
  @override
  Future<Iterable<TimeZone>> getListItems() async {
    await TimeZoneUtility.i.initialize();

    return filters.apply(TimeZoneUtility.i.locationMap.keys);
  }

  @override
  // TODO: Improve this logic to set the data from hive database.
  //
  bool isInFavorites(TimeZone zone, int index) => false;
}
