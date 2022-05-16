import 'package:flutter/material.dart';

import '../service/constants.dart';
import '../service/extension.dart';
import '../service/navigation_service/navigation_service.dart';
import '../service/theme/theme.dart';
import '../values/images.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomTheme.instance.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              Images.bg404,
              fit: BoxFit.cover,
              height: screenSize.height,
              width: screenSize.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "4:04",
                  style: TextStyle(
                      fontSize: 180,
                      color: CustomTheme.instance.accentTextColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Oops! It looks like we are lost in time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      color: CustomTheme.instance.primaryTextColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                Text(
                  "Here are the directions you can try",
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
                      onTap: () => context.goToRoute(route: RouteNames.home),
                      title: "Home",
                    ),
                    _ActionText(
                      onTap: () =>
                          context.goToRoute(route: RouteNames.timezoneList),
                      title: "Timezones",
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
  late final AnimationController _parent;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _parent = AnimationController(
      vsync: this,
      duration: Constants.defaultAnimationDuration,
    );
    _animation = Tween<double>(begin: 1, end: 1.1).animate(_parent);
  }

  @override
  void dispose() {
    _parent.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _animation,
      builder: (_, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: TextButton(
        onPressed: widget.onTap,
        onHover: (isHover) {
          if (isHover)
            _parent.forward();
          else
            _parent.reverse();
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
              CustomTheme.instance.primaryTextColor.withOpacity(0.1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 25,
            color: CustomTheme.instance.accentTextColor,
          ),
        ),
      ),
    );
  }
}
