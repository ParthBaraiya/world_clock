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
  CustomTicker get _timer => CustomTicker.secondTicker;

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
            text: '${Constants.hhMM.format(DateTime.now())} ',
            style: CustomTheme.instance.titleStyle.copyWith(
              fontSize: 55,
            ),
          ),
          TextSpan(
            text: DateTime.now().hour >= 12 ? 'PM' : 'AM',
            style: CustomTheme.instance.subtitleStyle,
          ),
        ],
      ),
    );
  }
}
