part of 'location_tile.dart';

mixin LocationTileBackend on State<TimezoneDetailsTile> {
  final saving = ValueNotifier(false);

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
    isFavorite.dispose();
    _dateTime.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TimezoneDetailsTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    _updateWidgetData();
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
