part of 'location_tile.dart';

mixin LocationTileBackend on State<LocationTile> {
  bool selected = false;
  bool saving = false;
  bool isExpanded = true;

  late List<Location> _locations;
  late TZDateTime _dateTime;

  @override
  void initState() {
    super.initState();

    _updateWidgetData();
  }

  @override
  void didUpdateWidget(LocationTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    _updateWidgetData();
  }

  void _updateWidgetData() {
    selected = widget.selected;
    _locations = TimeZoneUtility.i.locationMap[widget.timezone]!;
    _dateTime = TZDateTime.now(_locations[0]);
  }

  void _updateDateTime(TZDateTime newDate) {
    _dateTime = newDate;
    if (mounted) {
      setState(() {});
    }
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

    if (selected) {
      await HiveMain.instance
          .removeFavoriteTimeZone(widget.timezone.hiveTimezone);
    } else {
      await HiveMain.instance.addFavoriteTimeZone(widget.timezone.hiveTimezone);
    }
    await widget.onBookmark?.call(widget.timezone, !selected);

    if (mounted) {
      setState(() {
        saving = false;
        selected = !selected;
      });
    }
  }
}
