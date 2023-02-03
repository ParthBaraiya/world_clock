import 'package:flutter/material.dart';

import '../../service/timezone.dart';

class LocationTileExpansionSettings extends InheritedWidget {
  final List<TimeZone> shrinkedZones;
  final ValueChanged<TimeZone> _onExpand;
  final ValueChanged<TimeZone> _onShrink;

  const LocationTileExpansionSettings({
    super.key,
    required super.child,
    required this.shrinkedZones,
    required ValueChanged<TimeZone> onExpand,
    required ValueChanged<TimeZone> onShrink,
  })  : _onExpand = onExpand,
        _onShrink = onShrink;

  void expand(TimeZone zone) {
    _onExpand(zone);
  }

  void shrink(TimeZone zone) {
    _onShrink(zone);
  }

  @override
  bool updateShouldNotify(covariant LocationTileExpansionSettings oldWidget) =>
      oldWidget.shrinkedZones != shrinkedZones ||
      shrinkedZones.length != oldWidget.shrinkedZones.length;

  static LocationTileExpansionSettings of(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<LocationTileExpansionSettings>();

    assert(
        widget != null,
        'No instance of LocationTileExpansionSettings '
        'found in parent hirarchy.');

    return widget!;
  }
}

mixin LocationTileExpansionSettingsMixin<T extends StatefulWidget> on State<T> {
  final shrinkedZones = <TimeZone>[];

  void onExpand(TimeZone zone) {
    shrinkedZones.remove(zone);
    if (mounted) {
      setState(() {});
    }
  }

  void onShrink(TimeZone zone) {
    shrinkedZones.add(zone);
    if (mounted) {
      setState(() {});
    }
  }
}
