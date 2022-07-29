part of 'menu_item.dart';

mixin MenuItemBackend
    on SingleTickerProviderStateMixin<MenuItem>, State<MenuItem> {
  late final AnimationController _parent;
  late final Animation<double> _curvedAnimation;
  final double underLineWidth = 5;

  @override
  void initState() {
    super.initState();

    _parent = AnimationController(
      vsync: this,
      duration: Constants.defaultAnimationDuration,
    );

    _curvedAnimation =
        CurvedAnimation(parent: _parent, curve: Constants.curveGentle);
  }

  @override
  void dispose() {
    _parent.dispose();

    super.dispose();
  }

  void _onHover(isOver) {
    if (isOver) {
      debugPrint('Forward... ${widget.title}');
      _parent.forward();
    } else {
      debugPrint('Reverse... ${widget.title}');
      _parent.reverse();
    }
  }
}
