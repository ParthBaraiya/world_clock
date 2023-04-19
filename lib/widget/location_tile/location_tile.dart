import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app_services.dart';
import '../../models/hive_timezone/hive_timezone.dart';
import '../../service/constants.dart';
import '../../service/extension.dart';
import '../../service/theme/theme.dart';
import '../../service/timer.dart';
import '../../service/timezone.dart';
import '../../typedefs.dart';
import '../../values/enumerations.dart';
import '../../values/world_clock_icons.dart';
import '../listenable_builder.dart';
import 'location_tile_expansion_settings.dart';

part 'location_tile_backend.dart';

// This defines that there will be 1 pixel every minute.
const _kTimeLineWidth = 1440.0;

class LocationTile extends StatefulWidget {
  final TimeZone timezone;
  final FavoriteChangeCallback? onBookmark;
  final bool selected;

  const LocationTile({
    Key? key,
    required this.timezone,
    required this.selected,
    this.onBookmark,
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

          return InkWell(
            onTap: _toggleExpanded,
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
                            Constants.hhMM.format(_dateTime.value),
                            style: CustomTheme.instance.timezoneTitleStyle,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            Constants.a.format(_dateTime.value),
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
                          ValueListenableBuilder(
                            valueListenable: isExpanded,
                            builder: (_, value, __) {
                              return Icon(
                                value
                                    ? WorldClock.arrow_down
                                    : WorldClock.arrow_up,
                                size: 15,
                                color: CustomTheme.instance.primaryTextColor,
                              );
                            },
                          ),
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
                                  value
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                );
                              },
                            ),
                          )
                        ],
                      );
                    }),
                ValueListenableBuilder(
                  valueListenable: isExpanded,
                  builder: (_, value, __) {
                    return AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: value
                          ? ValueListenableBuilder(
                              valueListenable: _dateTime,
                              builder: (_, value, __) {
                                return TimeLinePageView(
                                  viewPortWidth: width - 40,
                                  location: _locations[0],
                                  onTimeChanged: _updateDateTime,
                                  initialTime: _dateTime.value,
                                  timezone: widget.timezone,
                                );
                              })
                          : const SizedBox.shrink(),
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

class TimeLinePageView extends StatefulWidget {
  const TimeLinePageView({
    super.key,
    required this.viewPortWidth,
    required this.location,
    this.onTimeChanged,
    this.initialTime,
    required this.timezone,
  });

  final double viewPortWidth;
  final Location location;
  final ValueChanged<TZDateTime>? onTimeChanged;
  final TZDateTime? initialTime;
  final TimeZone timezone;

  @override
  State<TimeLinePageView> createState() => _TimeLinePageViewState();
}

class _TimeLinePageViewState extends State<TimeLinePageView> {
  var _controller = PageController();
  double _width = 0.0;
  int itemCount = 1;
  late TZDateTime _scrolledDate;

  @override
  void initState() {
    super.initState();

    _updateController(widget.viewPortWidth, shouldAnimate: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TimeLinePageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_width != widget.viewPortWidth ||
        oldWidget.onTimeChanged != widget.onTimeChanged ||
        oldWidget.location != widget.location ||
        _scrolledDate != widget.initialTime) {
      _updateController(
        widget.viewPortWidth,
        shouldAnimate: oldWidget.initialTime != widget.initialTime,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_width != widget.viewPortWidth) {
      _updateController(widget.viewPortWidth);
    }
  }

  void _updateController(double newWidth, {bool shouldAnimate = true}) {
    _controller.dispose();
    itemCount = AppTimeConfigs.instance.timelineDays;
    _scrolledDate = widget.initialTime ?? TZDateTime.now(widget.location);
    final viewportFraction = _kTimeLineWidth / newWidth;
    _controller = PageController(viewportFraction: viewportFraction);
    _controller.addListener(() {
      final ms = ((_controller.position.pixels + (newWidth / 2)) * 60000 -
              _scrolledDate.timeZoneOffset.inMilliseconds)
          .toInt();
      _scrolledDate =
          TZDateTime.fromMillisecondsSinceEpoch(widget.location, ms);

      widget.onTimeChanged?.call(_scrolledDate);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final offset = ((_scrolledDate.millisecondsSinceEpoch +
                  _scrolledDate.timeZoneOffset.inMilliseconds) /
              60000) -
          (newWidth / 2);
      if (shouldAnimate) {
        _controller.animateTo(
          offset,
          duration: Constants.defaultAnimationDurationLong,
          curve: Constants.defaultAnimationCurve,
        );
      } else {
        _controller.jumpTo(offset);
      }
    });
    _width = newWidth;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            DecoratedBox(
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 50,
                  child: PageView.builder(
                    controller: _controller,
                    pageSnapping: false,
                    physics: const BouncingScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.down,
                    itemCount: itemCount,
                    itemBuilder: (_, index) => SizedBox(
                      height: 50,
                      width: _kTimeLineWidth,
                      child: FittedBox(
                        child: CustomPaint(
                          size: const Size(_kTimeLineWidth, 50),
                          painter: TimeLinePainter(
                            timeZone: widget.timezone,
                            format: TimeFormat.hour12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: ColoredBox(
                color: Colors.blue,
                child: SizedBox(
                  height: 90,
                  width: 1.5,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionalTranslation(
                translation: const Offset(0.5, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (_) {
                        return Text(
                          _scrolledDate.descriptiveDate,
                          style:
                              CustomTheme.instance.timezoneSubTitleAccentStyle,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Update this logic to paint the canvas based on timezone offset.
class TimeLinePainter extends CustomPainter {
  final TimeZone timeZone;
  final TimeFormat format;

  TimeLinePainter({
    required this.timeZone,
    required this.format,
  });

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
        final text = '${((i ~/ 60) % format.maxPossibleTime)}';
        top = size.height * 0.5;
        canvas.paintText(
          text: text == '0' && i != 1440 ? '12' : text,
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
  bool shouldRepaint(covariant TimeLinePainter oldDelegate) => false;
}
