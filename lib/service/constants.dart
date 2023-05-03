import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';

class Constants {
  Constants._();

  // TODO: Update this method.
  static const hhMM = 'hh : mm';
  static final DateFormat a = DateFormat('a');
  static const hhMMa = 'hh : mm a';
  static final DateFormat wDdMm = DateFormat('EEE, dd/MM');

  static const defaultAnimationDuration = Duration(milliseconds: 200);
  static const defaultAnimationDurationLong = Duration(milliseconds: 500);
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
