import 'package:flutter/animation.dart';

class Constants {
  Constants._();

  static const defaultAnimationDuration = Duration(milliseconds: 200);
  static const defaultAnimationDurationLong = Duration(milliseconds: 500);
  // Check this as well: Cubic(.58, 1, .8, 1.02)
  static const defaultAnimationCurve = Cubic(0.56, 0.97, 0.7, 1);
}

class AppTimeConfigs {
  static final instance = AppTimeConfigs.configure(
    maxTime: DateTime(275760),
    minTime: DateTime.fromMicrosecondsSinceEpoch(0),
  );

  final DateTime minTime;
  final DateTime maxTime;
  final int timelineDays;

  AppTimeConfigs.configure({
    required this.minTime,
    required this.maxTime,
  }) : timelineDays = maxTime.difference(minTime).inDays;
}

abstract class WorldClockDateFormats {
  static const hhMM = 'hh : mm';
  static final a = 'a';
  static const hhMMa = 'hh : mm a';
  static const dateMonth = 'dd MMMM';
  static const weekDay = 'EEEE';
}
