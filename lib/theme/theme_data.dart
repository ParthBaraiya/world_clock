part of 'theme.dart';

abstract class _ThemeData {
  late Color backgroundColor;
  late Color clockBackground;
  late Color primaryTextColor;
  late Color accentTextColor;
  late Color shadowColor;

  late TextStyle titleStyle;
  late TextStyle subtitleStyle;
  late TextStyle heading5;
  late TextStyle heading6;

  late TextStyle timezoneTitleStyle;
  late TextStyle timezoneSubTitleStyle;

  late TextStyle timezoneTitleAccentStyle;
  late TextStyle timezoneSubTitleAccentStyle;
}

class _LightThemeData implements _ThemeData {
  @override
  Color backgroundColor = const Color(0xff000000);

  @override
  Color clockBackground = const Color(0xffe0e0e0);

  @override
  Color accentTextColor = const Color(0xff2a00ff);

  @override
  Color primaryTextColor = const Color(0xffffffff);

  @override
  Color shadowColor = const Color(0xff040017);

  @override
  TextStyle titleStyle = const TextStyle(
    fontSize: 40,
    color: Colors.white,
  );

  @override
  TextStyle subtitleStyle = const TextStyle(
    color: Color(0xff2a00ff),
    fontSize: 20,
  );

  @override
  TextStyle heading5 = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 20,
  );

  @override
  TextStyle heading6 = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 15,
  );

  @override
  TextStyle timezoneTitleStyle = const TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.bold,

    fontSize: 30,
  );

  @override
  TextStyle timezoneSubTitleStyle = const TextStyle(
    color: Color(0xff2a00ff),
    fontSize: 15,
  );

  @override
  TextStyle timezoneTitleAccentStyle = const TextStyle(
    color: Color(0xff2a00ff),
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  @override
  TextStyle timezoneSubTitleAccentStyle = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 15,
  );
}

class _DarkThemeData implements _ThemeData {
  @override
  Color backgroundColor = const Color(0xff000000);

  @override
  Color clockBackground = const Color(0xff0e0e0e);

  @override
  Color accentTextColor = const Color(0xff2a00ff);

  @override
  Color primaryTextColor = const Color(0xffffffff);

  @override
  Color shadowColor = const Color(0xff040017);

  @override
  TextStyle titleStyle = const TextStyle(
    fontSize: 40,
    color: Colors.white,
  );

  @override
  TextStyle subtitleStyle = const TextStyle(
    color: Color(0xff2a00ff),
    fontSize: 20,
  );

  @override
  TextStyle heading5 = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 20,
  );

  @override
  TextStyle heading6 = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 15,
  );

  @override
  TextStyle timezoneTitleStyle = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 30,
  );

  @override
  TextStyle timezoneSubTitleStyle = const TextStyle(
    color: Color(0xff2a00ff),
    fontSize: 15,
  );

  @override
  TextStyle timezoneTitleAccentStyle = const TextStyle(
    color: Color(0xff2a00ff),
    fontSize: 30,
  );

  @override
  TextStyle timezoneSubTitleAccentStyle = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 15,
  );
}
