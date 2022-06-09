part of 'navigation_service.dart';

class NoTransitionRoute<T extends Object> extends OverlayRoute<T> {
  NoTransitionRoute({
    required RouteSettings settings,
    required this.builder,
  }) : super(settings: settings);

  final WidgetBuilder builder;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return <OverlayEntry>[OverlayEntry(builder: builder)];
  }
}
