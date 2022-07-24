import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../service/extension.dart';
import '../../service/navigation_service/navigation_service.dart';
import '../../widget/action_text/action_text.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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
      backgroundColor: theme.backgroundColor,
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
                      color: theme.primaryTextColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                Text(
                  'Here are the directions you can try',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: theme.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ActionText(
                      onTap: () => context.navigateTo(
                        routeConfig: HomePagePath(),
                      ),
                      title: 'Home',
                    ),
                    const SizedBox(width: 30),
                    ActionText(
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
