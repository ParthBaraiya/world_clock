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

    _locations = TimeZoneUtility.i.locationMap[widget.timezone]!;
    _dateTime = TZDateTime.now(_locations[0]);
  }

  @override
  void didUpdateWidget(LocationTile oldWidget) {
    super.didUpdateWidget(oldWidget);

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

    final success = await widget.onBookmark(widget.timezone, !selected);

    if (mounted) {
      setState(() {
        saving = false;
        if (success) selected = !selected;
      });
    }
  }
}
