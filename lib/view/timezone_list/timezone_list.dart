import 'package:flutter/material.dart';

import '../../service/constants.dart';
import '../../service/extension.dart';
import '../../service/theme/theme.dart';
import '../../service/timezone.dart';
import '../../values/world_clock_icons.dart';
import '../../widget/buttons.dart';

part 'list_backend.dart';

class TimezoneList extends StatefulWidget {
  const TimezoneList({Key? key}) : super(key: key);

  @override
  _TimezoneListState createState() => _TimezoneListState();
}

class _TimezoneListState extends State<TimezoneList> with TimeZoneListBackend {
  @override
  Widget build(BuildContext context) {
    final locations = TimeZoneUtility.i.locations.keys.toList();

    return Scaffold(
      backgroundColor: CustomTheme.instance.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomTheme.instance.backgroundColor,
              boxShadow: [
                if (_scrolled)
                  BoxShadow(
                    color: CustomTheme.instance.accentTextColor,
                    blurRadius: 20,
                    spreadRadius: -10,
                  ),
              ],
            ),
            child: Row(
              children: [
                InkWellButton(
                  onTap: context.previousPage,
                  radius: BorderRadius.circular(100.0),
                  hoverColor:
                      CustomTheme.instance.primaryTextColor.withOpacity(0.2),
                  child: Icon(
                    Icons.chevron_left,
                    size: 40,
                    color: CustomTheme.instance.primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TimeZoneUtility.i.initialized
                ? ListView.separated(
                    controller: _controller,
                    itemBuilder: (_, index) {
                      return LocationTile(
                        location: getLocation(locations[index]),
                      );
                    },
                    separatorBuilder: (_, __) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            CustomTheme.instance.accentTextColor,
                            Colors.transparent,
                          ],
                          begin: const Alignment(-2.2, 0),
                          end: const Alignment(2.2, 0),
                        ),
                      ),
                      height: 1,
                      width: double.infinity,
                    ),
                    itemCount: TimeZoneUtility.i.locations.length,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  final Location location;

  const LocationTile({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timezone = location.currentTimeZone;
    final now = TZDateTime.now(location);
    final offset = timezone.offset / (1000 * 3600);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Row(
        children: [
          Icon(
            WorldClock.disk,
            size: 10,
            color: CustomTheme.instance.primaryTextColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      Constants.hhMM.format(now),
                      style: CustomTheme.instance.timezoneTitleStyle,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      Constants.a.format(now),
                      style: CustomTheme.instance.timezoneSubTitleStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  Constants.wDdMm.format(now),
                  style: CustomTheme.instance.heading6,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    "${offset < 0 ? "-" : "+"}${offset.abs()}HRS",
                    style: CustomTheme.instance.timezoneSubTitleAccentStyle,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    timezone.abbreviation,
                    style: CustomTheme.instance.timezoneTitleAccentStyle,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                location.name,
                style: CustomTheme.instance.timezoneSubTitleAccentStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
