part of '../timezones.dart';

mixin TimeZoneListBackend on State<TimezoneList> {
  late final ScrollController _controller;
  var timezones = <TimeZone>[];

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    TimeZoneUtility.i.initialized.addListener(_reload);
    timezones = TimeZoneUtility.i.locationMap.keys.toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    TimeZoneUtility.i.initialized.removeListener(_reload);
    super.dispose();
  }

  void _reload() {
    timezones = TimeZoneUtility.i.locationMap.keys.toList();

    if (mounted) {
      setState(() {});
    }
  }
}
