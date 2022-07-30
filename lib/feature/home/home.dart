import 'package:flutter/material.dart' hide MenuItem;

import '../../service/extension.dart';
import '../../theme/theme.dart';
import '../../widget/clock/clock.dart';
import '../../widget/custom_scaffolds.dart';
import '../../widget/github_thumb.dart';
import 'home_menu_bar.dart';

part 'backend/home_backend.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeBackend {
  @override
  Widget build(BuildContext context) {
    const clockRadius = 400.0;

    return GradientScaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localizations.worldClock,
                  style: theme.titleStyle.copyWith(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      AnimatedClock(
                        radius: clockRadius,
                        opacity: _clockOpacity,
                        offset: _clockOffset,
                      ),
                      const HomeMenuBar(
                        centerOffset: clockRadius,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: GithubThumb(
              size: 100,
            ),
          )
        ],
      ),
    );
  }
}
