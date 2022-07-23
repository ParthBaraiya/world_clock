part of '../home.dart';

mixin HomeBackend on State<HomePage> {
  Offset _clockOffset = const Offset(0, 0.1);
  double _clockOpacity = 0;

  @override
  void initState() {
    super.initState();
    _animate();
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
}
