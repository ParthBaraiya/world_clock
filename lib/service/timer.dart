import 'dart:async';

import 'package:flutter/foundation.dart';

class ClockTimer extends ChangeNotifier {
  static final ClockTimer timer = ClockTimer._();

  final _duration = const Duration(seconds: 1);

  late DateTime _date;

  int _counter = 0;

  late Timer _timer;

  ClockTimer._() {
    _date = DateTime.now();
    _timer = Timer(_duration, () {});
    _tick();
  }

  int get elepsedSeconds => _counter;

  DateTime get currentDate => _date;

  int get hour => _date.hour;
  int get minute => _date.minute;
  int get second => _date.second;

  void _tick() {
    _timer.cancel();
    _counter++;
    _date = DateTime.now();
    _timer = Timer(_duration, _tick);
    notifyListeners();
  }
}
