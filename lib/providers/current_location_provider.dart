import 'package:flutter/material.dart';

import '../service/timezone.dart';

class CurrentLocationProvider extends InheritedWidget {
  const CurrentLocationProvider({
    super.key,
    required super.child,
    required this.location,
  });

  final Location location;

  static CurrentLocationProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<CurrentLocationProvider>();
    assert(result != null, 'No CurrentLocationProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant CurrentLocationProvider oldWidget) =>
      location != oldWidget.location;
}
