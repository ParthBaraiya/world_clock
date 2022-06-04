part of '../timezones.dart';

mixin TimeZoneListBackend on State<TimezoneList> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    TimeZoneUtility.i.initialized.addListener(_reload);
  }

  @override
  void dispose() {
    TimeZoneUtility.i.initialized.removeListener(_reload);
    _controller.dispose();
    super.dispose();
  }

  void _reload() {
    if (mounted) {
      setState(() {});
    }
  }
}
