part of '../timezones.dart';

mixin TimeZoneListBackend on State<TimezoneList> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    TimeZoneUtility.i.initialized.addListener(_reload);
  }

  @override
  void dispose() {
    _controller.dispose();
    TimeZoneUtility.i.initialized.removeListener(_reload);
    super.dispose();
  }

  void _reload() {
    if (mounted) {
      setState(() {});
    }
  }

  bool _toggleFavorite(TimeZone timezone, bool selected) {
    if (selected) {
      try {
        HiveMain.instance.addFavorite(timezone.hiveTimezone);
        return true;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      try {
        HiveMain.instance.removeFavorite(timezone.hiveTimezone);
        return true;
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return false;
  }
}
