part of '../home.dart';

mixin HomeBackend on State<HomePage> {
  Offset _clockOffset = const Offset(0, 0.1);
  double _clockOpacity = 0;

  late CustomThemeData theme;

  @override
  void initState() {
    super.initState();
    _animate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = context.theme;
  }

  void _animate() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _clockOffset = Offset.zero;
      _clockOpacity = 1;
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _onFavorites() {}

  void _onTimezones() {}

  void _onCompare() {}
}
