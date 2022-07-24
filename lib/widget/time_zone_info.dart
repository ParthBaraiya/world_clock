import 'package:flutter/material.dart';

import '../service/extension.dart';

class TimeZoneInfo extends StatelessWidget {
  const TimeZoneInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kolkata | India',
          style: theme.heading5,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '+12HRS | IST',
          style: theme.heading6,
        ),
      ],
    );
  }
}
