import 'package:flutter/material.dart';

import '../service/theme/theme.dart';

class TimeZoneInfo extends StatelessWidget {
  const TimeZoneInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kolkata | India',
          style: CustomTheme.instance.heading5,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '+12HRS | IST',
          style: CustomTheme.instance.heading6,
        ),
      ],
    );
  }
}
