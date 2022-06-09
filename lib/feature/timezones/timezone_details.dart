import 'package:flutter/material.dart';

import '../../service/timezone.dart';

class TimezoneDetails extends StatelessWidget {
  const TimezoneDetails({
    Key? key,
    required this.timeZone,
  }) : super(key: key);

  final TimeZone timeZone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Timezone details for: ${timeZone.abbreviation}'),
      ),
    );
  }
}
