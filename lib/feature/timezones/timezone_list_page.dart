part of 'timezones_old.dart';

class TimezoneListPage extends StatelessWidget {
  const TimezoneListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              // color: CustomTheme.instance.backgroundColor,
              gradient: LinearGradient(
                colors: [
                  theme.backgroundColor,
                  Colors.transparent,
                ],
              ),
            ),
            // padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                InkWellButton(
                  onTap: context.previousPage,
                  radius: BorderRadius.circular(100.0),
                  hoverColor: theme.primaryTextColor.withOpacity(0.2),
                  child: Icon(
                    Icons.chevron_left,
                    size: 40,
                    color: theme.primaryTextColor,
                  ),
                ),
                Text(
                  'All Timezones',
                  style: theme.timezoneTitleStyle,
                ),
              ],
            ),
          ),
          const Expanded(
            child: TimezoneList(),
          ),
        ],
      ),
    );
  }
}
