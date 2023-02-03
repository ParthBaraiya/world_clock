import 'package:intl/intl.dart';

class Constants {
  Constants._();

  static final DateFormat hhMM = DateFormat('hh : mm');
  static final DateFormat a = DateFormat('a');
  static final DateFormat hhMMa = DateFormat('hh : mm a');
  static final DateFormat wDdMm = DateFormat('EEE, dd/MM');

  static const defaultAnimationDuration = Duration(milliseconds: 200);
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
