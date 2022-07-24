import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';

class Constants {
  Constants._();

  static final DateFormat hhMM = DateFormat('hh : mm');
  static final DateFormat a = DateFormat('a');
  static final DateFormat hhMMa = DateFormat('hh : mm a');
  static final DateFormat wDdMm = DateFormat('EEE, dd/MM');

  static const defaultAnimationDuration = Duration(milliseconds: 300);
  static const duration800 = Duration(milliseconds: 800);
  static const curveGentle = Cubic(.7, 1.02, .84, .99);

  static const repositoryUrl = 'https://github.com/ParthBaraiya/world_clock';
}
