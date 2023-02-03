import 'dart:async';

import 'package:flutter/foundation.dart';

class CustomTicker extends ChangeNotifier {
  static final secondTicker =
      CustomTicker(duration: const Duration(seconds: 1));
  static final minuteTicker =
      CustomTicker(duration: const Duration(minutes: 1));

  final Duration duration;

  late final Timer _timer;

  CustomTicker({required this.duration}) {
    _tick();
  }

  void _tick() {
    _timer = Timer.periodic(duration, (_) => notifyListeners());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
