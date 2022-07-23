part of 'navigation_service.dart';

class NoTransitionPage<T> extends Page<T> {
  const NoTransitionPage({
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
  Route<T> createRoute(BuildContext context) => NoTransitionPageRoute<T>(this);
}

class NoTransitionPageRoute<T> extends PageRoute<T> {
  NoTransitionPageRoute(RouteSettings page) : super(settings: page);

  NoTransitionPage<T> get _page => settings as NoTransitionPage<T>;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: _page.builder(context),
      );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => _page.maintainState;

  @override
  Duration get transitionDuration => Duration.zero;
}

extension PageExtension on Widget {
  Page page({
    required LocalKey key,
    required String routeName,
    required WorldClockRouteConfig config,
  }) {
    return NoTransitionPage(
      key: key,
      builder: (_) => this,
      name: routeName,
      arguments: config,
    );
  }
}
