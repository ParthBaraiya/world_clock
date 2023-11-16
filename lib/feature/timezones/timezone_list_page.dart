part of 'timezones.dart';

class TimezoneListPage extends GradientScaffold {
  const TimezoneListPage({super.key})
      : super(
          body: const AllTimezonesListWidget(),
          title: 'All timezones',
        );
}
