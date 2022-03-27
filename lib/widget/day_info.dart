import 'package:flutter/material.dart';

import '../service/extension.dart';
import '../service/theme/theme.dart';
import '../service/timer.dart';

class DayInfo extends StatefulWidget {
  const DayInfo({Key? key}) : super(key: key);

  @override
  _DayInfoState createState() => _DayInfoState();
}

class _DayInfoState extends State<DayInfo> {
  late final ClockTimer _timer;

  @override
  void initState() {
    super.initState();

    _timer = ClockTimer.timer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _timer.currentDate.weekName,
          style: CustomTheme.instance.heading5,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          _timer.currentDate.dateMonth,
          style: CustomTheme.instance.heading5,
        ),
      ],
    );
  }
}
