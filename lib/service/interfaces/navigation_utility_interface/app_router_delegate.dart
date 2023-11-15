import 'dart:collection';

import 'package:flutter/material.dart';

import 'app_route_config.dart';

abstract class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouteConfig> {
  AppRouterDelegate({required AppRouteConfig initialPage})
      : _routeConfig = initialPage;

  AppRouteConfig _routeConfig;

  //#region Public Variables
  /// Returns an unmodifiable list of pages.
  UnmodifiableListView<Page> get pages;
  //#endregion

  //#region Overrides
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Generates new navigator stack.
    generateNavigatorStack(context);

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: _onPopPage,
    );
  }

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    _routeConfig = configuration;
  }

  @override
  AppRouteConfig get currentConfiguration => _routeConfig;
  //#endregion

  //#region Public Methods
  void setRouteConfig(AppRouteConfig config) {
    if (_routeConfig != config) {
      _routeConfig = config;
      notifyListeners();
    }
  }

  /// Generates the navigator stack and store it in pages variable.
  void generateNavigatorStack(BuildContext context);
  //#endregion

  //#region Private Methods
  /// Gets called whenever user pops a page from the stack...
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result) ||
        route.settings.arguments == null ||
        route.settings.arguments is! AppRouteConfig ||
        pages.length < 2) {
      return false;
    }

    final oldConfig = _routeConfig;

    _routeConfig = pages[pages.length - 2].arguments! as AppRouteConfig;

    final updated = oldConfig != _routeConfig;

    if (updated) {
      notifyListeners();
    }

    return updated;
  }
  //#endregion
}
