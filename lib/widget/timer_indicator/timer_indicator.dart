import 'package:flutter/material.dart';

import '../../service/constants.dart';
import '../../service/extension.dart';
import '../../service/timer.dart';
import '../../theme/theme.dart';

part 'timer_indicator_backend.dart';

class TimeIndicator extends StatefulWidget {
  const TimeIndicator({Key? key}) : super(key: key);

  @override
  _TimeIndicatorState createState() => _TimeIndicatorState();
}

class _TimeIndicatorState extends State<TimeIndicator>
    with TimeIndicatorBackend {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${Constants.hhMM.format(_timer.currentDate)} ',
            style: theme.titleStyle.copyWith(
              fontSize: 55,
            ),
          ),
          TextSpan(
            text: _timer.currentDate.hour >= 12 ? 'PM' : 'AM',
            style: theme.subtitleStyle,
          ),
        ],
      ),
    );
  }
}
