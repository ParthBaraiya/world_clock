import 'package:flutter/cupertino.dart';

mixin ReloadWidgetMixin<T extends StatefulWidget> on State<T> {
  void reload() {
    if (mounted) {
      setState(() {});
    }
  }
}
