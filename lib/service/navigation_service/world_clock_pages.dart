part of 'navigation_service.dart';

class WorldClockPage extends Page {
  final Widget child;

  const WorldClockPage({
    LocalKey? key,
    required this.child,
    required String name,
    required WorldClockRouteConfig config,
  }) : super(
          key: key,
          name: name,
          arguments: config,
        );

  @override
  Route createRoute(BuildContext context) {
    return NoTransitionRoute(
      settings: this,
      builder: (_) => child,
    );
  }
}

extension PageExtension on Widget {
  Page page({
    required LocalKey key,
    required String routeName,
    required WorldClockRouteConfig config,
  }) {
    return NoTransitionPage(
      key: key,
      child: this,
      name: routeName,
      arguments: config,
    );
  }
}
