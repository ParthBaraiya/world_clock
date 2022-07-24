part of 'timer_indicator.dart';

mixin TimeIndicatorBackend on State<TimeIndicator> {
  ClockTimer get _timer => ClockTimer.timer;

  late CustomThemeData theme;

  @override
  void initState() {
    super.initState();

    _timer.addListener(_reload);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = context.theme;
  }

  @override
  void dispose() {
    _timer.removeListener(_reload);

    super.dispose();
  }

  void _reload() {
    if (mounted) setState(() {});
  }
}
