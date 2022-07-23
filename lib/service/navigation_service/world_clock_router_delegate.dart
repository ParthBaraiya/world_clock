import 'package:flutter/material.dart';

import '../../feature/error_404.dart';
import '../../feature/home/home.dart';
import '../../feature/responsive_home_page.dart';
import '../../feature/timezones/timezone_details.dart';
import '../../feature/timezones/timezones.dart';
import 'navigation_service.dart';

class WorldClockRouterDelegate extends RouterDelegate<WorldClockRouteConfig>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<WorldClockRouteConfig> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WorldClockRouteConfig _routeConfig = HomePagePath();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pages = <Page>[];

    Page _getPage(Widget child) => child.page(
          // Defines when a page can update.
          key: ValueKey(pages.length),
          routeName: _routeConfig.getPath(),
          config: _routeConfig,
        );

    if (_routeConfig is InvalidPath) {
      pages.add(_getPage(const Error404Page()));
    } else {
      if (width < 800) {
        pages.add(_getPage(const HomePage()));
      } else if (_routeConfig is HomePagePath) {
        pages.add(
          _getPage(
            ResponsiveHomePage(
              mobilePage: const TimezoneListPage(),
              index: 0,
            ),
          ),
        );
      }

      if (_routeConfig is FavoritesPath) {
        final path = _routeConfig as FavoritesPath;
        pages.add(
          _getPage(
            path.timezone == null
                ? ResponsiveHomePage(
                    mobilePage: const TimezoneListPage(),
                    index: 0,
                  )
                : TimezoneDetails(
                    timeZone: path.timezone!,
                  ),
          ),
        );
      } else if (_routeConfig is TimezonePath) {
        final path = _routeConfig as TimezonePath;

        pages.add(
          _getPage(
            path.timezone == null
                ? ResponsiveHomePage(
                    mobilePage: const TimezoneListPage(),
                    index: 1,
                  )
                : TimezoneDetails(
                    timeZone: path.timezone!,
                  ),
          ),
        );
      }
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result) ||
            route.settings.arguments == null ||
            route.settings.arguments is! WorldClockRouteConfig) {
          return false;
        }

        _routeConfig = route.settings.arguments! as WorldClockRouteConfig;
        notifyListeners();

        return true;
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
}
