import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class WorldClockService<T extends Object> extends ValueNotifier<T?> {
  final int retries;

  WorldClockService({
    required this.retries,
  }) : super(null);

  Future<bool> get isInitialized => _completer?.future ?? Future.value(false);

  Completer<bool>? _completer;

  Future<void> initializeService(AsyncCallback callback) {
    if (_completer != null && !_completer!.isCompleted) {
      return _completer!.future;
    }

    _completer = Completer();

    callback().then((value) {
      if (_completer != null && !_completer!.isCompleted) {
        _completer!.complete(true);
      }
    }).catchError((e, stack) {
      if (_completer != null && !_completer!.isCompleted) {
        _completer!.complete(false);
      }
    });

    return _completer!.future;
  }
}
