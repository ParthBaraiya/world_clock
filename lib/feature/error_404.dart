import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../service/constants.dart';
import '../service/extension.dart';
import '../service/navigation_service/navigation_service.dart';
import '../service/theme/theme.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final aspectRatio = 860.13137 / 571.14799;
    late double imageWidth;

    if (screenSize.width > 1000) {
      imageWidth = 700;
    } else {
      imageWidth = screenSize.width * 0.75;
    }

    final imageHeight = imageWidth / aspectRatio;

    return Scaffold(
      backgroundColor: CustomTheme.instance.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.vectors.pageNotFound.svg(
                  width: imageWidth,
                  height: imageHeight,
                ),
                const SizedBox(height: 100),
                Text(
                  'Oops! It looks like we are lost in time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      color: CustomTheme.instance.primaryTextColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                Text(
                  'Here are the directions you can try',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: CustomTheme.instance.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ActionText(
                      onTap: () => context.navigateTo(
                        routeConfig: HomePagePath(),
                      ),
                      title: 'Home',
                    ),
                    const SizedBox(width: 30),
                    _ActionText(
                      onTap: () =>
                          context.navigateTo(routeConfig: TimezonePath.list()),
                      title: 'Timezones',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionText extends StatefulWidget {
  const _ActionText({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  State<_ActionText> createState() => _ActionTextState();
}

class _ActionTextState extends State<_ActionText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      duration: Constants.defaultAnimationDuration,
    );
  }

  @override
  void dispose() {
    _animation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _animation,
      builder: (_, value, child) {
        return CustomPaint(
          child: child,
          painter: LinePainter(
            listenable: _animation,
            lineColor: CustomTheme.instance.accentTextColor,
          ),
        );
      },
      child: TextButton(
        onPressed: widget.onTap,
        onHover: (isHover) {
          if (isHover)
            _animation.forward();
          else
            _animation.reverse();
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 22,
            color: CustomTheme.instance.accentTextColor,
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Animation<double> listenable;
  final Color lineColor;
  LinePainter({required this.listenable, required this.lineColor})
      : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    final lineWidth = size.width * listenable.value;
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    final top = size.height - 4;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, top, lineWidth, size.height),
      const Radius.circular(20),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) =>
      listenable != oldDelegate.listenable;
}
