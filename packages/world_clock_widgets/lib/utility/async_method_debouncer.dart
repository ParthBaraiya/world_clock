import 'dart:async';

class AsyncMethodCallDebouncer<T> {
  final Future<T> Function() callback;
  final bool cacheResult;

  AsyncMethodCallDebouncer({
    required this.callback,
    this.cacheResult = false,
  });

  Completer<T>? _completer;

  Future<T> call({bool? showCached}) {
    if (_completer != null &&
        (!_completer!.isCompleted ||
            (showCached != null && showCached) ||
            cacheResult)) {
      return _completer!.future;
    }

    _completer = Completer();
    _caller(_completer!);
    return _completer!.future;
  }

  Future<void> _caller(Completer<T> completer) async {
    try {
      final value = await callback();

      if (!completer.isCompleted) {
        completer.complete(value);
      }
    } catch (e, stack) {
      if (!completer.isCompleted) {
        completer.completeError(e, stack);
      }
    } finally {
      if (!completer.isCompleted) {
        // NOTE: This is just for safety purpose. Also, DO NOT REMOVE the
        // condition for isCompleted check.
        //
        completer.completeError('Something went wrong!');
      }
    }
  }
}
