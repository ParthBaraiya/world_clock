part of '../timezones.dart';

mixin TimeZoneListBackend on State<TimezoneList> {
  final _controller = ScrollController();

  bool _scrolled = false;

  @override
  void initState() {
    super.initState();

    _waitInitialized();

    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _waitInitialized() async {
    while (!TimeZoneUtility.i.initialized) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _scrollListener() {
    if (_controller.offset <= 0 && _scrolled) {
      if (mounted) {
        setState(() {
          _scrolled = false;
        });
      }
    } else if (!_scrolled) {
      if (mounted) {
        setState(() {
          _scrolled = true;
        });
      }
    }
  }
}
