part of '../timezones.dart';

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
