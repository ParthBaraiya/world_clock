import 'dart:async';

import 'package:flutter/material.dart';
import 'package:world_clock/app_services.dart';
import 'package:world_clock/service/timezone.dart';
import 'package:world_clock/widget/timezone_listing_widgets/timezone_listing_with_filters.dart';

class FavoritesTimezonesListWidget extends StatefulWidget {
  const FavoritesTimezonesListWidget({super.key});

  @override
  State<FavoritesTimezonesListWidget> createState() =>
      _FavoritesTimezonesListWidgetState();
}

class _FavoritesTimezonesListWidgetState
    extends TimezoneListingWithFiltersWidgetState<
        FavoritesTimezonesListWidget> {
  @override
  Future<Iterable<TimeZone>> getListItems() async {
    final initialized = await AppServices.hive.isInitialized;

    if (initialized) {
      final box = AppServices.hive.favoriteTimezonesBox.value;
      if (box != null) {
        return box.values.map((e) => e.timezone);
      }
    }

    throw 'Error while loading data.';
  }

  @override
  bool isInFavorites(TimeZone zone, int index) => true;
}
