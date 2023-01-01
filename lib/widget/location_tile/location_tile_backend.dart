part of 'location_tile.dart';

mixin LocationTileBackend on State<LocationTile> {
  bool selected = false;
  bool saving = false;
  bool isExpanded = false;

  late List<Location> _locations;
  late TZDateTime _dateTime;

  late final PageController _controller;

  double? _width;

  @override
  void initState() {
    super.initState();

    _locations = TimeZoneUtility.i.locationMap[widget.timezone]!;
    _dateTime = TZDateTime.now(_locations[0]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final width = context.mediaSize.width;

    if (_width == null || _width != width) {
      _width = width;

      _controller.dispose();
      _controller = PageController(viewportFraction: 1440 / _width!);
      _controller.jumpTo();
    }
  }

  @override
  void didUpdateWidget(LocationTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    selected = widget.selected;
  }

  void _toggleExpanded() {
    isExpanded = !isExpanded;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _toggleFavorite() async {
    if (mounted) {
      setState(() {
        saving = true;
      });
    }

    final success = await widget.onBookmark(widget.timezone, !selected);

    if (mounted) {
      setState(() {
        saving = false;
        if (success) selected = !selected;
      });
    }
  }
}
