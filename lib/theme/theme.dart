import 'package:flutter/material.dart';

import '../service/shared_preferences.dart';
import 'theme_data.dart';

export 'theme_data.dart';

class CustomThemeProvider extends StatefulWidget {
  static final globalKey = GlobalKey<_CustomThemeProviderState>();

  CustomThemeProvider({
    required this.builder,
  }) : super(key: globalKey);

  final WidgetBuilder builder;

  @override
  State<CustomThemeProvider> createState() => _CustomThemeProviderState();
}

class _CustomThemeProviderState extends State<CustomThemeProvider> {
  ThemeMode _mode = ThemeMode.light;
  CustomThemeData _data = CustomThemeData.dark;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  /// This function will have effect only once.
  void _initialize() {
    final mode = SPService.i.getThemeMode();
    _mode = mode;
  }

  void _setThemeData() {
    _data =
        _mode == ThemeMode.light ? CustomThemeData.dark : CustomThemeData.dark;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTheme(
      child: Builder(
        builder: widget.builder,
      ),
      data: _data,
    );
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    if (_mode != mode) {
      await SPService.i.setTheme(mode);
      _mode = mode;
      _setThemeData();
      setState(() {});
    }
  }
}

class CustomTheme extends InheritedWidget {
  const CustomTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final CustomThemeData data;

  static CustomThemeData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<CustomTheme>();
    assert(result != null, 'No CustomTheme found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) => oldWidget.data != data;
}
