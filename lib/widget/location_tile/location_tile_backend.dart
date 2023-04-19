part of 'location_tile.dart';

mixin LocationTileBackend on State<LocationTile> {
  final saving = ValueNotifier(false);
  final isExpanded = ValueNotifier(true);

  late final isFavorite = ValueNotifier<bool>(widget.selected);
  late List<Location> _locations;
  late final _dateTime = ValueNotifier(TZDateTime.now(_locations[0]));

  @override
  void initState() {
    super.initState();
    CustomTicker.minuteTicker.addListener(_tickerCallback);
    _updateWidgetData();
  }

  @override
  void dispose() {
    CustomTicker.minuteTicker.removeListener(_tickerCallback);
    saving.dispose();
    isExpanded.dispose();
    isFavorite.dispose();
    _dateTime.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LocationTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    _updateWidgetData();
    _updateExpansion();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateExpansion();
  }

  void _updateExpansion() {
    isExpanded.value = !LocationTileExpansionSettings.of(context)
        .shrinkedZones
        .contains(widget.timezone);
  }

  void _updateWidgetData() {
    isFavorite.value = widget.selected;
    _locations = TimeZoneUtility.i.locationMap[widget.timezone]!;
    _dateTime.value = TZDateTime.now(_locations[0]);
  }

  void _updateDateTime(TZDateTime newDate) {
    _dateTime.value = newDate;
  }

  void _tickerCallback() {
    _updateDateTime(TZDateTime.now(_locations[0]));
  }

  void _toggleExpanded() {
    isExpanded.value = !isExpanded.value;
    if (isExpanded.value) {
      LocationTileExpansionSettings.of(context).expand(widget.timezone);
    } else {
      LocationTileExpansionSettings.of(context).shrink(widget.timezone);
    }
  }

  Future<void> _toggleFavorite() async {
    saving.value = true;

    if (isFavorite.value) {
      await AppServices.hive
          .removeFavoriteTimeZone(widget.timezone.hiveTimezone);
    } else {
      await AppServices.hive.addFavoriteTimeZone(widget.timezone.hiveTimezone);
    }
    await widget.onBookmark?.call(widget.timezone, !isFavorite.value);

    saving.value = false;
    isFavorite.value = !isFavorite.value;
  }
}
