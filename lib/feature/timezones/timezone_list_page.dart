part of 'timezones.dart';

class TimeZoneListPage extends StatefulWidget {
  const TimeZoneListPage({super.key});

  @override
  State<TimeZoneListPage> createState() => _TimeZoneListPageState();
}

class _TimeZoneListPageState extends State<TimeZoneListPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final newSize = size.copyWith(width: size.width / 2);
    return Align(
      alignment: Alignment.centerRight,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          size: newSize,
        ),
        child: SizedBox.fromSize(
          size: newSize,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Material(
                color: const Color.fromRGBO(42, 0, 255, 0.02),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            size: 34,
                          ),
                          const SizedBox(width: 40),
                          Text(
                            'Timezones',
                            style: CustomTheme.instance.titleStyle.copyWith(
                              fontSize: 34,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: AllTimezonesListWidget(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimezoneListPageOld extends GradientScaffold {
  const TimezoneListPageOld({super.key})
      : super(
          body: const AllTimezonesListWidget(),
          title: 'All timezones',
        );
}
