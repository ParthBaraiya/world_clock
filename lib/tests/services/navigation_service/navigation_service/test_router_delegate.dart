part of 'test_navigation_service.dart';

class TextRouterDelegate extends AppRouterDelegate {
  TextRouterDelegate({required super.initialPage});

  /// Returns an unmodifiable list of pages.
  @override
  UnmodifiableListView<Page> get pages => UnmodifiableListView(_pages);

  //#region Private Variables
  var _pages = <Page>[];
  //#endregion

  /// Generates the navigator stack and store it in pages variable.
  @override
  void generateNavigatorStack(BuildContext context) {
    _pages.clear();
    _pages = <Page>[];

    if (currentConfiguration is InvalidPath) {
      _pages.add(_getPage(const Error404Page(), InvalidPath()));
      return;
    }

    if (currentConfiguration is TestHomePagePath) {
      _pages.add(_getPage(const TestHomePage(), currentConfiguration));
    } else if (currentConfiguration is ClockTestPagePath) {
      _pages.add(_getPage(const ClockTest(), currentConfiguration));
    } else if (currentConfiguration is TimeLineTestPath) {
      _pages.add(_getPage(const TimeLineTest(), currentConfiguration));
    }
  }

  //#region PrivateMethods
  Page _getPage(Widget child, AppRouteConfig config) => child.page(
        // Defines when a page can update.
        key: ValueKey(pages.length),
        routeName: config.getPath(),
        config: config,
      );
  //#endregion
}
