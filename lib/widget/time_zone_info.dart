import 'package:flutter/material.dart';

import '../providers/current_location_provider.dart';
import '../service/extension.dart';
import '../service/theme/theme.dart';

class TimeZoneInfo extends StatelessWidget {
  const TimeZoneInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = CurrentLocationProvider.of(context).location;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          location.name,
          style: CustomTheme.instance.heading5,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${location.currentTimeZone.offsetInHour} HRS | ${location.currentTimeZone.abbreviation}',
          style: CustomTheme.instance.heading6,
        ),
      ],
    );
  }
}
