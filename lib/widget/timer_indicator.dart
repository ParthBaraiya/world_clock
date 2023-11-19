import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import '../providers/current_location_provider.dart';
import '../service/constants.dart';
import '../service/custom_ticker.dart';
import '../service/extension.dart';
import '../service/theme/theme.dart';

class TimeIndicator extends StatefulWidget {
  const TimeIndicator({Key? key}) : super(key: key);

  @override
  _TimeIndicatorState createState() => _TimeIndicatorState();
}

class _TimeIndicatorState extends State<TimeIndicator> {
  CustomTicker get _timer => CustomTicker.secondTicker;

  late Location _location;

  @override
  void initState() {
    super.initState();

    _timer.addListener(_reload);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _location = CurrentLocationProvider.of(context).location;
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
    final time = TZDateTime.now(_location);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${time.format(WorldClockDateFormats.hhMMa)} ',
            style: CustomTheme.instance.titleStyle.copyWith(
              fontSize: 55,
            ),
          ),
        ],
      ),
    );
  }
}
