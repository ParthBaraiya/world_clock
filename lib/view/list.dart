import 'package:flutter/material.dart';
import '../service/timezone.dart';
import '../theme/theme.dart';

class TimezoneList extends StatefulWidget {
  const TimezoneList({Key? key}) : super(key: key);

  @override
  _TimezoneListState createState() => _TimezoneListState();
}

class _TimezoneListState extends State<TimezoneList> {
  @override
  void initState() {
    super.initState();

    _waitInitialized();
  }

  Future<void> _waitInitialized() async {
    while (!TimeZoneUtility.i.initialized) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final locations = TimeZoneUtility.i.locations.keys.toList();

    return Scaffold(
      backgroundColor: CustomTheme.i.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: TimeZoneUtility.i.initialized
          ? ListView.builder(
              itemBuilder: (_, index) {
                final loc = getLocation(locations[index]);
                final now = TZDateTime.now(loc);

                return Text("${loc.name} - $now");
              },
              itemCount: TimeZoneUtility.i.locations.length,
            )
          : Container(),
    );
  }
}
