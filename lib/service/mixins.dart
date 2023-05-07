import 'package:flutter/material.dart';

import '../app_services.dart';

mixin ShowDialogMixin<T extends Object> on Widget {
  Future<T?> show() {
    return showDialog(
      context: AppServices.navigationService.navigator!.context,
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
