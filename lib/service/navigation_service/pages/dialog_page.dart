import 'package:flutter/material.dart';
import 'package:world_clock/service/interfaces/navigation_utility_interface/app_route_config.dart';

class WorldClockDialogPage<T> extends Page<T> {
  const WorldClockDialogPage({
    LocalKey? key,
    required this.builder,
    this.maintainState = true,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
        );

  final bool maintainState;
  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) =>
      WorldClockDialogRoute<T>(this, context, builder);
}

class WorldClockDialogRoute<T> extends DialogRoute<T> {
  // TODO: Provide animation and reverse animation while building the page
  // So, child widget can animate according.
  WorldClockDialogRoute(
      RouteSettings page, BuildContext context, WidgetBuilder builder)
      : super(
          settings: page,
          builder: builder,
          context: context,
        );
}

extension DialogExtension on Widget {
  Page dialog({
    required LocalKey key,
    required String routeName,
    required AppRouteConfig config,
  }) {
    return WorldClockDialogPage(
      key: key,
      builder: (_) => this,
      name: routeName,
      arguments: config,
    );
  }
}
