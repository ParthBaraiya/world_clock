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
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Row(
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
          Text(
            Constants.hhMM.format(now),
            style: CustomTheme.instance.timezoneTitleStyle,
          ),
          const SizedBox(width: 10),
          Text(
            Constants.a.format(now),
            style: CustomTheme.instance.timezoneSubTitleStyle,
          ),
          SizedBox(
            width: size.width * 0.45 * 0.25,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        location.name,
                        style: CustomTheme.instance.timezoneSubTitleAccentStyle,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  "${offset < 0 ? "-" : "+"}${offset.abs()}HRS",
                  style: CustomTheme.instance.timezoneSubTitleAccentStyle,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {},
            child: const Icon(WorldClock.arrow_up),
          )
        ],
      ),
    );
  }
}
