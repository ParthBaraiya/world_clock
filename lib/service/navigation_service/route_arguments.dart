part of 'navigation_service.dart';

abstract class SerializableRouteArgument {
  Map<String, String> toJson();
}

class EmptyRouteArgument implements SerializableRouteArgument {
  const EmptyRouteArgument();

  @override
  Map<String, String> toJson() => {};
}
