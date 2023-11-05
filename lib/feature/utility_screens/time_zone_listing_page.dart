import 'package:flutter/material.dart';
import 'package:world_clock/feature/utility_screens/searchble_listing_page.dart';
import 'package:world_clock/service/timezone.dart';

class TimeZoneListingPage extends StatefulWidget {
  const TimeZoneListingPage({
    super.key,
    required this.timezones,
  });

  final List<TimeZone> timezones;

  @override
  State<TimeZoneListingPage> createState() => _TimeZoneListingPageState();
}

class _TimeZoneListingPageState extends State<TimeZoneListingPage>
    with SearchableListingPageMixin<TimeZoneListingPage, TimeZone> {
  @override
  Widget builder(BuildContext context, int index) {
    return Text('timezone');
  }

  @override
  bool includeItem(String query, TimeZone item) {
    // return item.name.toLowerCase().contains(q) ||
    //     item.currentTimeZone.abbreviation.toLowerCase().contains(q);

    return true;
  }

  @override
  List<TimeZone> get items => widget.timezones;
}
