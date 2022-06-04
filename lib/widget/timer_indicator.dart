import 'package:flutter/material.dart';

import '../service/constants.dart';
import '../service/theme/theme.dart';
import '../service/timer.dart';

class TimeIndicator extends StatefulWidget {
  const TimeIndicator({Key? key}) : super(key: key);

  @override
  _TimeIndicatorState createState() => _TimeIndicatorState();
}

class _TimeIndicatorState extends State<TimeIndicator> {
  ClockTimer get _timer => ClockTimer.timer;

  @override
  void initState() {
    super.initState();

    _timer.addListener(_reload);
  }

  @override
  void dispose() {
    _timer.removeListener(_reload);

    super.dispose();
  }

  void _reload() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${Constants.hhMM.format(_timer.currentDate)} ',
            style: CustomTheme.instance.titleStyle,
          ),
          TextSpan(
            text: _timer.currentDate.hour >= 12 ? 'PM' : 'AM',
            style: CustomTheme.instance.subtitleStyle,
          ),
        ],
      ),
    );
  }
}
