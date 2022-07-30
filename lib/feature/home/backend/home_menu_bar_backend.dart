part of '../home_menu_bar.dart';

mixin HomeMenuBarBackend on State<HomeMenuBar> {
  late WidgetMode mode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _calculateWidgetMode();
  }

  void _onFavorites() {}

  void _onTimezones() {}

  void _onCompare() {}

  void _calculateWidgetMode() {
    if (context.media.size.width < 1000) {
      mode = WidgetMode.mobile;
    } else {
      mode = WidgetMode.desktop;
    }
  }
}
