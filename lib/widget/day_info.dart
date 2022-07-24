import 'package:flutter/material.dart';

import '../service/extension.dart';
import '../service/timer.dart';

class DayInfo extends StatelessWidget {
  const DayInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ClockTimer.timer.currentDate.weekName,
          style: theme.heading5,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          ClockTimer.timer.currentDate.dateMonth,
          style: theme.heading5,
        ),
      ],
    );
  }
}
