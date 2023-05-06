import 'dart:collection';

import 'package:flutter/material.dart';

import '../../feature/error_404.dart';
import '../../feature/favorites/favorites_web_page.dart';
import '../../feature/home/home.dart';
import '../../feature/responsive_home_page.dart';
import '../../feature/timezones/timezone_details.dart';
import '../../feature/timezones/timezones.dart';
import '../../feature/timezones/timezones_web_page.dart';
import '../../values/breakpoints.dart';
import 'navigation_service.dart';

class WorldClockRouterDelegate extends RouterDelegate<WorldClockRouteConfig>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<WorldClockRouteConfig> {
  //#region Public Variables
  /// Returns an unmodifiable list of pages.
  UnmodifiableListView<Page> get pages => UnmodifiableListView(_pages);
  //#endregion

  //#region Private Variables
  WorldClockRouteConfig _routeConfig = HomePagePath();
  var _pages = <Page>[];
  //#endregion

  //#region Overrides
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Generate new navigator stack.
    _generateNavigatorStack(context);

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: _onPopPage,
    );
  }

  @override
  Future<void> setNewRoutePath(WorldClockRouteConfig configuration) async {
    _routeConfig = configuration;
  }

  @override
  WorldClockRouteConfig get currentConfiguration => _routeConfig;
  //#endregion

  //#region Public Methods
  void setRouteConfig(WorldClockRouteConfig config) {
    if (_routeConfig != config) {
      _routeConfig = config;
      notifyListeners();
    }
  }
  //#endregion

  //#region Private Methods

  // Local method.
  //
  Page _getPage(Widget child, WorldClockRouteConfig config) => child.page(
        // Defines when a page can update.
        key: ValueKey(pages.length),
        routeName: config.getPath(),
        config: config,
      );

  /// Generates the navigator stack and store it in pages variable.
  void _generateNavigatorStack(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    _pages.clear();
    _pages = <Page>[];

    if (_routeConfig is InvalidPath) {
      _pages.add(_getPage(const Error404Page(), InvalidPath()));
      return;
    }

    // Add home page if width is less then 800 px or current route is HomePage.
    if (width < HomeScreenBreakPoints.point800) {
      _pages.add(_getPage(const HomePage(), HomePagePath()));
    } else if (_routeConfig is HomePagePath) {
      _pages.add(
        _getPage(
          const DesktopHomePage(
            widget: TimezoneListPage(),
            index: 0,
          ),
          _routeConfig,
        ),
      );
    }

    if (_routeConfig is FavoritesPath) {
      final path = _routeConfig as FavoritesPath;

      _pages.add(
        _getPage(
          path.timezone == null
              ? const FavoritesDesktopPage()
              : TimezoneDetails(
                  timeZone: path.timezone!,
                ),
          _routeConfig,
        ),
      );
    } else if (_routeConfig is TimezonePath) {
      final path = _routeConfig as TimezonePath;

      _pages.add(
        _getPage(
          path.timezone == null
              ? const TimezonesDesktopPage()
              : TimezoneDetails(
                  timeZone: path.timezone!,
                ),
          _routeConfig,
        ),
      );
    }
  }

  /// Gets called whenever user pops a page from the stack...
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result) ||
        route.settings.arguments == null ||
        route.settings.arguments is! WorldClockRouteConfig ||
        pages.length < 2) {
      return false;
    }

    final oldConfig = _routeConfig;

    _routeConfig = pages[pages.length - 2].arguments! as WorldClockRouteConfig;

    final updated = oldConfig != _routeConfig;

    if (updated) {
      notifyListeners();
    }

    return updated;
  }
  //#endregion
}
