import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'navigation_service/navigation_service.dart';

extension ComparisonExtension on Size {
  double get max => math.max(width, height);

  double get min => math.min(width, height);

  Offset toOffset() => Offset(width, height);
}

extension DateFormatExtension on DateTime {
  String get weekName => DateFormat("EEEE").format(this);
  String get dateMonth => DateFormat("d MMM").format(this);
}

extension NavigationExtension on BuildContext {
  void goToRoute<T>({
    required String route,
    SerializableRouteArgument params = const EmptyRouteArgument(),
    SerializableRouteArgument queryParams = const EmptyRouteArgument(),
  }) =>
      goNamed(
        route,
        params: params.toJson(),
        queryParams: queryParams.toJson(),
      );

  void goToLocation({
    required String url,
  }) =>
      go(url);

  void previousPage() => pop();
}
