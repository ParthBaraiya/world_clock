part of 'timezones.dart';

class TimezoneList extends StatefulWidget {
  const TimezoneList({Key? key}) : super(key: key);

  @override
  _TimezoneListState createState() => _TimezoneListState();
}

class _TimezoneListState extends State<TimezoneList> with TimeZoneListBackend {
  @override
  Widget build(BuildContext context) {
    final locations = TimeZoneUtility.i.locations.keys.toList();

    return TimeZoneUtility.i.initialized
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
