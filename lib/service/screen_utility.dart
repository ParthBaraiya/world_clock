import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class ScreenUtility {
  static SingletonFlutterWindow get window => WidgetsBinding.instance.window;

  static Size get size {
    return Size(width, height);
  }

  static double get height {
    return window.physicalSize.height / window.devicePixelRatio;
  }

  static double get width {
    return window.physicalSize.width / window.devicePixelRatio;
  }
}
