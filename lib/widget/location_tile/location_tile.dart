import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../service/constants.dart';
import '../../service/extension.dart';
import '../../service/theme/theme.dart';
import '../../service/timezone.dart';
import '../../typedefs.dart';
import '../../values/world_clock_icons.dart';

part 'location_tile_backend.dart';

class LocationTile extends StatefulWidget {
  final TimeZone timezone;
  final FavoriteChangeCallback onBookmark;
  final bool selected;

  const LocationTile({
    Key? key,
    required this.timezone,
    required this.onBookmark,
    required this.selected,
  }) : super(key: key);

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> with LocationTileBackend {
  @override
  Widget build(BuildContext context) {
    final offset = widget.timezone.offset / (1000 * 3600);

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
                Constants.hhMM.format(_dateTime),
                style: CustomTheme.instance.timezoneTitleStyle,
              ),
              const SizedBox(width: 10),
              Text(
                Constants.a.format(_dateTime),
                style: CustomTheme.instance.timezoneSubTitleStyle,
              ),
            ],
          );

          final offsetWidget = Text(
            "${offset < 0 ? "-" : "+"}${offset.abs()}HRS",
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

          return InkWell(
            onTap: _toggleExpanded,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      WorldClock.disk,
                      size: 10,
                      color: CustomTheme.instance.primaryTextColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.timezone.abbreviation,
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
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: isExpanded
                      ? SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: DecoratedBox(
                              position: DecorationPosition.foreground,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black
                                  ],
                                  stops: [0, 0.3, 0.5, 0.7, 1],
                                ),
                              ),
                              child: LayoutBuilder(
                                builder: (_, constraints) => PageView.builder(
                                  controller: _controller,
                                  pageSnapping: false,
                                  physics: const BouncingScrollPhysics(),
                                  dragStartBehavior: DragStartBehavior.down,
                                  itemCount: TZDateTime.now(_locations[0])
                                      .difference(
                                          TZDateTime.fromMillisecondsSinceEpoch(
                                              _locations[0], 0))
                                      .inDays,
                                  itemBuilder: (_, index) => SizedBox(
                                    height: 50,
                                    width: 1440,
                                    child: FittedBox(
                                      child: CustomPaint(
                                        size: const Size(1440, 50),
                                        painter: ClockPainter(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final singleOffset = size.width / 1440;

    final numberStyle = const TextStyle(
      fontSize: 15,
      color: Colors.white,
    );

    for (var i = 15; i < 1441; i += 15) {
      var top = size.height * 0.7;
      final x = singleOffset * i;

      if (i % 60 == 0) {
        final text = '${i ~/ 60}';
        top = size.height * 0.5;
        canvas.paintText(
          text: i == 1440 ? '0' : text,
          minWidth: 2,
          maxWidth: 300,
          offset: Offset(x, top - 12),
          style: numberStyle,
        );
      }

      canvas.drawLine(
        Offset(x, top),
        Offset(x, size.height),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) => false;
}
