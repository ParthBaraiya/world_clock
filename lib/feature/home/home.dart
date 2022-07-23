import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../service/theme/theme.dart';
import '../../widget/clock/clock.dart';
import '../../widget/custom_scaffolds.dart';
import '../../widget/github_thumb.dart';

part 'backend/home_backend.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeBackend {
  @override
  Widget build(BuildContext context) {
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
                  AppLocalizations.of(context)!.worldClock,
                  style: CustomTheme.instance.titleStyle.copyWith(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: AnimatedClock(
                    radius: 400,
                    opacity: _clockOpacity,
                    offset: _clockOffset,
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
