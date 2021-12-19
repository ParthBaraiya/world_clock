// Place fonts/world_clock.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: world_clock
//      fonts:
//       - asset: fonts/world_clock.ttf
import 'package:flutter/widgets.dart';

class WorldClock {
  WorldClock._();

  static const String _fontFamily = 'World Clock';

  static const IconData exchange = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData more = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData arrow_down = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData arrow_up = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData disk = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData spinner = IconData(0xe97a, fontFamily: _fontFamily);
}
