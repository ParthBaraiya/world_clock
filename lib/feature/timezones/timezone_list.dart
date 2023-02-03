part of 'timezones.dart';

class TimezoneList extends StatefulWidget {
  const TimezoneList({Key? key}) : super(key: key);

  @override
  _TimezoneListState createState() => _TimezoneListState();
}

class _TimezoneListState extends State<TimezoneList>
    with LocationTileExpansionSettingsMixin, TimeZoneListBackend {
  @override
  Widget build(BuildContext context) {
    final locations = TimeZoneUtility.i.locationMap.keys.toList();

    return TimeZoneUtility.i.initialized.value
        ? LocationTileExpansionSettings(
            onShrink: onShrink,
            onExpand: onExpand,
            shrinkedZones: shrinkedZones,
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black
                  ],
                  stops: [0, 0.15, 0.5, 0.9, 1],
                ),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 50),
                controller: _controller,
                itemBuilder: (_, index) {
                  return LocationTile(
                    key: ValueKey(locations[index]),
                    timezone: locations[index],
                    selected: HiveMain.instance.favoriteLocationsBox.values
                        .contains(locations[index].hiveTimezone),
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
                  height: 0.2,
                  width: double.infinity,
                ),
                itemCount: TimeZoneUtility.i.locationMap.length,
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SpinKitRipple(
                      color: CustomTheme.instance.accentTextColor,
                      size: 300,
                    ),
                    Assets.vectors.locationSearch.svg(height: 200),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Loading time zone list...',
                  style: CustomTheme.instance.timezoneTitleAccentStyle,
                ),
              ],
            ),
          );
  }
}
