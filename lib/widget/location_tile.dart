import 'package:flutter/material.dart';

import '../service/constants.dart';
import '../service/theme/theme.dart';
import '../service/timezone.dart';
import '../values/world_clock_icons.dart';

class LocationTile extends StatefulWidget {
  final Location location;
  final ValueChanged<bool> onBookmark;
  final bool selected;

  const LocationTile({
    Key? key,
    required this.location,
    required this.onBookmark,
    required this.selected,
  }) : super(key: key);

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  bool selected = false;

  @override
  void initState() {
    super.initState();

    selected = widget.selected;
  }

  @override
  void didUpdateWidget(LocationTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    final timezone = widget.location.currentTimeZone;
    final now = TZDateTime.now(widget.location);
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
            widget.location.name,
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
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selected = !selected;
                    });
                    widget.onBookmark(selected);
                  }
                },
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
