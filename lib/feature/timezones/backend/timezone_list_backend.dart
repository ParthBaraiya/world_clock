part of '../timezones.dart';

mixin TimeZoneListBackend
    on State<TimezoneList> {
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
}
