part of 'timezones.dart';

class TimezoneListPage extends StatelessWidget {
  const TimezoneListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.instance.backgroundColor,
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
                  CustomTheme.instance.backgroundColor,
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
                  hoverColor:
                      CustomTheme.instance.primaryTextColor.withOpacity(0.2),
                  child: Icon(
                    Icons.chevron_left,
                    size: 40,
                    color: CustomTheme.instance.primaryTextColor,
                  ),
                ),
                Text(
                  "All Timezones",
                  style: CustomTheme.instance.timezoneTitleStyle,
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
