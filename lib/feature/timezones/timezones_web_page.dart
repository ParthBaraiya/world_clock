import '../responsive_home_page.dart';
import 'timezones.dart';

class TimezonesDesktopPage extends DesktopHomePage {
  const TimezonesDesktopPage({super.key})
      : super(
          widget: const TimezoneListPage(),
          index: 1,
        );
}
