part of 'location_tile.dart';

mixin LocationTileBackend on State<TimezoneTile> {
  bool selected = false;
  bool saving = false;

  @override
  void initState() {
    super.initState();

    selected = widget.selected;
  }

  @override
  void didUpdateWidget(TimezoneTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    selected = widget.selected;
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
