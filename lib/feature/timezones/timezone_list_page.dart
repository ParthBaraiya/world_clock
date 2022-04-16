part of 'timezones.dart';

class TimezonesPage extends StatelessWidget {
  const TimezonesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final clockWidgetWidth = screenWidth < HomeScreenBreakPoints.point800
        ? screenWidth
        : screenWidth * 0.45;

    final isMobile = screenWidth < HomeScreenBreakPoints.point800;

    return ResponsiveSplitRightWidget(
      left: (_) => HomePageClock(
        width: clockWidgetWidth,
      ),
      right: (_) =>
          isMobile ? const TimezoneList() : const TimeZoneTab(index: 1),
    );
  }
}

// class TimezoneListPage extends StatelessWidget {
//   const TimezoneListPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomTheme.instance.backgroundColor,
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: CustomTheme.instance.backgroundColor,
//             ),
//             child: Row(
//               children: [
//                 InkWellButton(
//                   onTap: context.previousPage,
//                   radius: BorderRadius.circular(100.0),
//                   hoverColor:
//                       CustomTheme.instance.primaryTextColor.withOpacity(0.2),
//                   child: Icon(
//                     Icons.chevron_left,
//                     size: 40,
//                     color: CustomTheme.instance.primaryTextColor,
//                   ),
//                 ),
//                 const Text("All Timezones"),
//               ],
//             ),
//           ),
//           const Expanded(
//             child: TimezoneList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
