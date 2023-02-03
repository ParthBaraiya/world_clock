import 'package:flutter/material.dart';

class ListenableBuilder extends StatefulWidget {
  const ListenableBuilder({
    super.key,
    required this.listenable,
    required this.builder,
  });

  final Listenable listenable;
  final WidgetBuilder builder;

  @override
  State<ListenableBuilder> createState() => _ListenableBuilderState();
}

class _ListenableBuilderState extends State<ListenableBuilder> {
  @override
  void initState() {
    super.initState();

    widget.listenable.addListener(_reload);
  }

  @override
  void didUpdateWidget(covariant ListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.listenable != widget.listenable) {
      oldWidget.listenable.removeListener(_reload);
      widget.listenable.addListener(_reload);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_reload);
    super.dispose();
  }

  void _reload() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
