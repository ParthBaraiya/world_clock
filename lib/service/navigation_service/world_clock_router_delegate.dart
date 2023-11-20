import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_clock/feature/home/home_screen.dart';
import 'package:world_clock/service/extension.dart';
import 'package:world_clock/service/navigation_service/pages/dialog_page.dart';
import 'package:world_clock/service/navigation_service/pages/no_transition_page.dart';

import '../../feature/error_404.dart';
import '../../feature/home_old/desktop_home_page.dart';
import '../../feature/timezones/timezone_details.dart';
import '../../feature/timezones/timezones.dart';
import '../interfaces/navigation_utility_interface/app_route_config.dart';
import '../interfaces/navigation_utility_interface/app_router_delegate.dart';
import 'navigation_service.dart';

class WorldClockRouterDelegate extends AppRouterDelegate {
  WorldClockRouterDelegate({required super.initialPage});

  /// Returns an unmodifiable list of pages.
  @override
  UnmodifiableListView<Page> get pages => UnmodifiableListView(_pages);

  //#region Private Variables
  var _pages = <Page>[];
  //#endregion

  /// Generates the navigator stack and store it in pages variable.
  @override
  void generateNavigatorStack(BuildContext context) {
    final width = context.mediaSize.width;
    _pages.clear();
    _pages = <Page>[];

    if (currentConfiguration is InvalidPath) {
      _pages.add(_getPage(const Error404Page(), InvalidPath()));
      return;
    }

    // Add home page if width is less then 800 px or current route is HomePage.
    // if (width < HomeScreenBreakPoints.point800) {
    //   _pages.add(_getPage(kDebugMode ? const HomePageOld() : const HomeScreen(),
    //       HomePagePath()));
    // } else if (currentConfiguration is HomePagePath) {
    if (kDebugMode) {
      _pages.add(_getPage(
        const HomeScreen(),
        currentConfiguration,
      ));
    } else {
      _pages.add(
        _getPage(
          const DesktopHomePage(
            widget: TimezoneListPageOld(),
            index: 0,
          ),
          currentConfiguration,
        ),
      );
    }
    // }

    if (currentConfiguration is FavoritesPath) {
      final path = currentConfiguration as FavoritesPath;

      _pages.add(
        _getDialog(
          path.timezone == null
              ? const TimeZoneListPage()
              : TimezoneDetails(
                  timeZone: path.timezone!,
                ),
          currentConfiguration,
        ),
      );
    } else if (currentConfiguration is TimezonePath) {
      final path = currentConfiguration as TimezonePath;

      _pages.add(
        _getPage(
          path.timezone == null
              ? const DesktopHomePage(
                  widget: TimezoneListPageOld(),
                  index: 1,
                )
              : TimezoneDetails(
                  timeZone: path.timezone!,
                ),
          currentConfiguration,
        ),
      );
    }
  }

  //#region PrivateMethods
  Page _getPage(Widget child, AppRouteConfig config) => child.page(
        // Defines when a page can update.
        key: ValueKey(pages.length),
        routeName: config.getPath(),
        config: config,
      );

  Page _getDialog(Widget child, AppRouteConfig config) => child.dialog(
        // Defines when a page can update.
        key: ValueKey(pages.length),
        routeName: config.getPath(),
        config: config,
      );
  //#endregion
}
