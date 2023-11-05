import 'package:flutter/foundation.dart';

@immutable
abstract class AppRouteConfig {
  static const pathFragment = '';

  final String domain = pathFragment;

  String getPath() => '/$domain';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRouteConfig && domain == other.domain;
}

class InvalidPath extends AppRouteConfig {
  static const pathFragment = '/invalid';
  @override
  final String domain = pathFragment;
}
