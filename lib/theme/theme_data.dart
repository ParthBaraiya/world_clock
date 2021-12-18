part of 'theme.dart';

abstract class _ThemeData {
  late Color backgroundColor;
  late Color clockBackground;
  late Color primaryTextColor;
  late Color accentTextColor;
  late Color shadowColor;
}

class _LightThemeData implements _ThemeData {
  @override
  Color backgroundColor = Colors.white;

  @override
  Color clockBackground = const Color(0xffe0e0e0);

  @override
  Color accentTextColor = const Color(0xff2a00ff);

  @override
  Color primaryTextColor = Colors.white;

  @override
  Color shadowColor = const Color(0xff040017);
}

class _DarkThemeData implements _ThemeData {
  @override
  Color backgroundColor = Colors.black;

  @override
  Color clockBackground = const Color(0xff0e0e0e);

  @override
  Color accentTextColor = const Color(0xff2a00ff);

  @override
  Color primaryTextColor = Colors.white;

  @override
  Color shadowColor = const Color(0xff040017);
}
