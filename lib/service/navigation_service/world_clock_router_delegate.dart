import 'dart:collection';

import 'package:flutter/material.dart';

import '../../feature/error_404.dart';
import '../../feature/home/home.dart';
import '../../feature/responsive_home_page.dart';
import '../../feature/timezones/timezone_details.dart';
import '../../feature/timezones/timezones.dart';
import '../../values/breakpoints.dart';
import 'navigation_service.dart';

class WorldClockRouterDelegate extends RouterDelegate<WorldClockRouteConfig>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<WorldClockRouteConfig> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WorldClockRouteConfig _routeConfig = HomePagePath();

  var _pages = <Page>[];

  UnmodifiableListView<Page> get pages => UnmodifiableListView(_pages);

  @override
  Widget build(BuildContext context) {
    _generateNavigatorStack(context);

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result) ||
            route.settings.arguments == null ||
            route.settings.arguments is! WorldClockRouteConfig ||
            pages.length < 2) {
          return false;
        }

        final oldConfig = _routeConfig;

        _routeConfig =
            pages[pages.length - 2].arguments! as WorldClockRouteConfig;

        final updated = oldConfig != _routeConfig;

        if (updated) {
          notifyListeners();
        }

        return updated;

        // if (route.settings.arguments is TimezonePath ||
        //     route.settings.arguments is FavoritesPage) {
        //   _routeConfig = HomePagePath();
        //   notifyListeners();
        //   return true;
        // } else {
        //   _routeConfig = route.settings.arguments! as WorldClockRouteConfig;
        //   notifyListeners();
        //   return false;
        // }
      },
    );
  }

  @override
  Future<void> setNewRoutePath(WorldClockRouteConfig configuration) async {
    _routeConfig = configuration;
  }

  @override
  WorldClockRouteConfig get currentConfiguration => _routeConfig;

  void setRouteConfig(WorldClockRouteConfig config) {
    if (_routeConfig != config) {
      _routeConfig = config;
      notifyListeners();
    }
  }

  void _generateNavigatorStack(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    _pages.clear();
    _pages = <Page>[];

    Page _getPage(Widget child) => child.page(
          // Defines when a page can update.
          key: ValueKey(pages.length),
          routeName: _routeConfig.getPath(),
          config: _routeConfig,
        );
        
    if (_routeConfig is InvalidPath) {
      _pages.add(_getPage(const Error404Page()));
      return;
    }

    if (width < HomeScreenBreakPoints.point800) {
      _pages.add(_getPage(const HomePage()));
    } else if (_routeConfig is HomePagePath) {
      _pages.add(
        _getPage(
          const WebHomePage(
            widget: TimezoneListPage(),
            index: 0,
          ),
        ),
      );
    }

    if (_routeConfig is FavoritesPath) {
      final path = _routeConfig as FavoritesPath;
      _pages.add(
        _getPage(
          path.timezone == null
              ? const WebHomePage(
                  widget: TimezoneListPage(),
                  index: 0,
                )
              : TimezoneDetails(
                  timeZone: path.timezone!,
                ),
        ),
      );
    } else if (_routeConfig is TimezonePath) {
      final path = _routeConfig as TimezonePath;

      _pages.add(
        _getPage(
          path.timezone == null
              ? const WebHomePage(
                  widget: TimezoneListPage(),
                  index: 1,
                )
              : TimezoneDetails(
                  timeZone: path.timezone!,
                ),
        ),
      );
    }
  }
}
