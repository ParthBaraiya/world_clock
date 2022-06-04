import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/error_404.dart';
import '../../feature/favorites/favorite.dart';
import '../../feature/home/home.dart';
import '../../feature/responsive_home_page.dart';
import '../../feature/timezones/timezones.dart';

part 'route_arguments.dart';

class NavigationService {
  static final instance = NavigationService._();
  NavigationService._();

  final router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        pageBuilder: (_, __) => _getPage(
          child: const ResponsiveHomePage(
            mobilePage: HomePage(),
            index: 0,
          ),
        ),
        routes: [
          GoRoute(
            name: RouteNames.timezoneList,
            path: 'timezones',
            pageBuilder: (_, __) => _getPage(
              child: const ResponsiveHomePage(
                mobilePage: TimezoneListPage(),
                index: 1,
              ),
            ),
          ),
          GoRoute(
            name: RouteNames.favorites,
            path: 'favorites',
            pageBuilder: (_, __) => _getPage(
              child: const ResponsiveHomePage(
                mobilePage: FavoritesPage(),
                index: 0,
              ),
            ),
          ),
        ],
      ),
    ],
    redirect: (state) {
      if (state.location == '/' && kIsWeb) {
        return '/${RouteNames.favorites}';
      }

      return null;
    },
    errorBuilder: (_, state) {
      // TODO: improve this...
      return const Error404Page();
    },
  );

  static Page<void> _getPage({required Widget child}) {
    return NoTransitionPage(child: child);
  }

  RouterDelegate<Object> get delegate => router.routerDelegate;
  RouteInformationParser<Object> get routeInformationParser =>
      router.routeInformationParser;
}

class RouteNames {
  RouteNames._();

  static const home = 'home';
  static const timezoneList = 'timezone-list';
  static const timezoneComparison = 'timezone-comparison';
  static const favorites = 'favorites';

  static const list = [
    home,
    timezoneList,
    timezoneComparison,
  ];
}
