part of '../timezones.dart';

mixin TimeZoneListBackend on State<TimezoneList> {
  @override
  void initState() {
    super.initState();

    TimeZoneUtility.i.initialized.addListener(_reload);
  }

  @override
  void dispose() {
    TimeZoneUtility.i.initialized.removeListener(_reload);
    super.dispose();
  }

  void _reload() {
    if (mounted) {
      setState(() {});
    }
  }

  bool _toggleFavorite(Location location, bool selected) {
    if (selected) {
      try {
        HiveMain.instance.addFavorite(location.hiveLocation);
        return true;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      try {
        HiveMain.instance.removeFavorite(location.hiveLocation);
        return true;
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return false;
  }
}
