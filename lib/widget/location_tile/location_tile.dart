import 'package:flutter/material.dart';

import '../../app_services.dart';
import '../../models/hive_timezone/hive_timezone.dart';
import '../../service/constants.dart';
import '../../service/custom_ticker.dart';
import '../../service/extension.dart';
import '../../service/theme/theme.dart';
import '../../service/timezone.dart';
import '../../typedefs.dart';

part 'location_tile_backend.dart';

// This defines that there will be 1 pixel every minute.
const _kTimeLineWidth = 1440.0;

class TimezoneDetailsTile extends StatefulWidget {
  final TimeZone timezone;
  final FavoriteChangeCallback? onBookmark;
  final bool selected;

  const TimezoneDetailsTile({
    Key? key,
    required this.timezone,
    required this.selected,
    this.onBookmark,
  }) : super(key: key);

  @override
  State<TimezoneDetailsTile> createState() => _TimezoneDetailsTileState();
}

class _TimezoneDetailsTileState extends State<TimezoneDetailsTile>
    with LocationTileBackend {
  @override
  Widget build(BuildContext context) {
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

          return InkWell(
            onTap: () {
              // TODO: Improve this...
              if (_locations.isNotEmpty) {
                AppServices.app.currentState?.setLocation(_locations.first);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                  valueListenable: _dateTime,
                  builder: (_, value, __) {
                    final timeWidget = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _dateTime.value.format(WorldClockDateFormats.hhMM),
                          style: CustomTheme.instance.timezoneTitleStyle,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _dateTime.value.format(WorldClockDateFormats.a),
                          style: CustomTheme.instance.timezoneSubTitleStyle,
                        ),
                      ],
                    );

                    final offsetWidget = Text(
                      '${widget.timezone.offsetInHour} HRS',
                      style: CustomTheme.instance.timezoneSubTitleAccentStyle,
                    );

                    final locationWidget = Text(
                      _locations[0].name,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  '|',
                                  style: CustomTheme
                                      .instance.timezoneSubTitleAccentStyle,
                                ),
                              ),
                              offsetWidget,
                            ],
                          ),
                      ],
                    );
                    return Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                widget.timezone.abbreviation,
                                style: CustomTheme
                                    .instance.timezoneTitleAccentStyle,
                              ),
                              Tooltip(
                                message: 'Reset',
                                child: IconButton(
                                  onPressed: _updateWidgetData,
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
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
                          child: ValueListenableBuilder(
                            valueListenable: isFavorite,
                            builder: (_, value, __) {
                              return Icon(
                                value ? Icons.bookmark : Icons.bookmark_outline,
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
