import 'package:flutter/material.dart';

import '../../service/constants.dart';
import '../../service/theme/theme.dart';
import '../../service/timezone.dart';
import '../../typedefs.dart';
import '../../values/world_clock_icons.dart';

part 'location_tile_backend.dart';

class TimezoneTile extends StatefulWidget {
  final TimeZone timezone;
  final FavoriteChangeCallback onBookmark;
  final bool selected;

  const TimezoneTile({
    Key? key,
    required this.timezone,
    required this.onBookmark,
    required this.selected,
  }) : super(key: key);

  @override
  State<TimezoneTile> createState() => _TimezoneTileState();
}

class _TimezoneTileState extends State<TimezoneTile> with LocationTileBackend {
  @override
  Widget build(BuildContext context) {
    final timezone = widget.timezone;
    final location = TimeZoneUtility.i.locationMap[timezone]![0];
    final now = TZDateTime.now(location);

    final offset = timezone.offset / (1000 * 3600);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          final isDeskTop = width >= 500;
          var zoneWidth = 0.0;

          if (isDeskTop) {
            zoneWidth = width * 0.23;
          } else {
            zoneWidth = width * 0.5;
          }

          final timeWidget = Row(
            mainAxisSize: MainAxisSize.min,
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
          );

          final offsetWidget = Text(
            "${offset < 0 ? "-" : "+"}${offset.abs()}HRS",
            style: CustomTheme.instance.timezoneSubTitleAccentStyle,
          );

          final locationWidget = Text(
            location.name,
            style: CustomTheme.instance.timezoneSubTitleAccentStyle,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          );

          final zoneDetails = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isDeskTop) locationWidget else timeWidget,
              const SizedBox(height: 7),
              if (isDeskTop)
                offsetWidget
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: locationWidget),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        '|',
                        style: CustomTheme.instance.timezoneSubTitleAccentStyle,
                      ),
                    ),
                    offsetWidget,
                  ],
                ),
            ],
          );

          return Row(
            children: [
              Icon(
                WorldClock.disk,
                size: 10,
                color: CustomTheme.instance.primaryTextColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  timezone.abbreviation,
                  style: CustomTheme.instance.timezoneTitleAccentStyle,
                ),
              ),
              if (isDeskTop) timeWidget,
              SizedBox(
                width: zoneWidth,
                child: zoneDetails,
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: _toggleFavorite,
                child: Icon(
                  selected ? Icons.bookmark : Icons.bookmark_outline,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
