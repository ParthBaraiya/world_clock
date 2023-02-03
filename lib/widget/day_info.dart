import 'package:flutter/material.dart';

import '../service/extension.dart';
import '../service/theme/theme.dart';

class DayInfo extends StatelessWidget {
  const DayInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateTime.now().weekName,
          style: CustomTheme.instance.heading5,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          DateTime.now().dateMonth,
          style: CustomTheme.instance.heading5,
        ),
      ],
    );
  }
}
