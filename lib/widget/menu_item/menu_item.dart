import 'package:flutter/material.dart';

import '../../service/constants.dart';
import '../../service/extension.dart';
import '../../utils/painters/animated_underline_painter.dart';

part 'menu_item_backend.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem>
    with SingleTickerProviderStateMixin, MenuItemBackend {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: widget.onTap,
      onHover: _onHover,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            widget.icon,
            size: 36,
            color: theme.primaryTextColor,
          ),
          const SizedBox(width: 16),
          CustomPaint(
            painter: AnimatedUnderLinePainter(
              listenable: _curvedAnimation,
              lineWidth: underLineWidth,
              lineColor: theme.accentTextColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: underLineWidth + 6),
              child: Text(
                widget.title,
                style: theme.titleStyle.copyWith(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
