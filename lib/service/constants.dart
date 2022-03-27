import 'package:intl/intl.dart';

class Constants {
  Constants._();

  static final DateFormat hhMM = DateFormat("hh : mm");
  static final DateFormat a = DateFormat("a");
  static final DateFormat hhMMa = DateFormat("hh : mm a");
  static final DateFormat wDdMm = DateFormat("EEE, dd/MM");

  static const defaultAnimationDuration = Duration(milliseconds: 200);
}
