import 'package:flutter/material.dart';

import '../../service/theme/theme.dart';
import '../../widget/clock/clock.dart';
import '../../widget/custom_scaffolds.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  'World Clock',
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
            // ClipPath()
          ],
        ),
      ),
    );
  }
}
