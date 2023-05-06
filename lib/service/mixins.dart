import 'package:flutter/material.dart';

import 'navigation_service/navigation_service.dart';

mixin ShowDialogMixin<T extends Object> on Widget {
  Future<T?> show() {
    return showDialog(
      context: NavigationService.instance.navigatorKey.currentState!.context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.transparent,
      routeSettings: settings,
      builder: (_) => this,
    );
  }

  // NOTE: Right now we are making this abstract and force all the dialogs to
  // have a route settings.
  RouteSettings? get settings;

  bool get barrierDismissible => true;
}
