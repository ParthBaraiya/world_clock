part of 'timezones.dart';

class TimezoneList extends StatefulWidget {
  const TimezoneList({Key? key}) : super(key: key);

  @override
  _TimezoneListState createState() => _TimezoneListState();
}

class _TimezoneListState extends State<TimezoneList> with TimeZoneListBackend {
  @override
  Widget build(BuildContext context) {
    return TimeZoneUtility.i.initialized.value
        ? DecoratedBox(
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
            child: ValueListenableBuilder<bool?>(
              valueListenable: AppServices.hive,
              builder: (_, value, child) {
                if (value ?? false) return child!;

                return const Text('Hive is not initialized.');
              },
              child: ValueListenableBuilder(
                valueListenable: AppServices.hive.favoriteTimezonesBox,
                builder: (_, value, __) {
                  if (value == null) {
                    return const Text('Loading favorites...');
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    controller: _controller,
                    itemBuilder: (_, index) {
                      try {
                        return LocationTile(
                          key: ValueKey(timezones[index]),
                          timezone: timezones[index],
                          selected: value.values
                              .contains(timezones[index].hiveTimezone),
                        );
                      } catch (e) {
                        return Text("No Timezones found...");
                      }
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
                  );
                },
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
