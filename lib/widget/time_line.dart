// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import '../service/constants.dart';
// import '../service/extension.dart';
//
// class TimeLineWidget extends StatefulWidget {
//   const TimeLineWidget({super.key});
//
//   @override
//   State<TimeLineWidget> createState() => _TimeLineWidgetState();
// }
//
// class _TimeLineWidgetState extends State<TimeLineWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 10,
//         ),
//         child: DecoratedBox(
//           position: DecorationPosition.foreground,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black,
//                 Colors.transparent,
//                 Colors.transparent,
//                 Colors.transparent,
//                 Colors.black
//               ],
//               stops: [0, 0.3, 0.5, 0.7, 1],
//             ),
//           ),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             dragStartBehavior: DragStartBehavior.down,
//             itemBuilder: (_, index) => SizedBox(
//               height: 50,
//               width: 1440,
//               child: FittedBox(
//                 child: CustomPaint(
//                   size: const Size(1440, 50),
//                   painter: ClockPainter(
//                     offset: ValueNotifier(10),
//                     date: Constants.minDate.add(Duration(days: index)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ClockPainter extends CustomPainter {
//   ClockPainter({required this.offset, required this.date})
//       : super(repaint: offset);
//
//   final ValueNotifier<int> offset;
//   final DateTime date;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final singleOffset = size.width / 1440;
//
//     final numberStyle = const TextStyle(
//       fontSize: 15,
//       color: Colors.white,
//     );
//
//     for (var i = 15; i < 1441; i += 15) {
//       var top = size.height * 0.7;
//       final x = singleOffset * i;
//
//       if (i % 60 == 0) {
//         final text = '${i ~/ 60}';
//         top = size.height * 0.5;
//         canvas.paintText(
//           text: i == 1440 ? '0' : text,
//           minWidth: 2,
//           maxWidth: 300,
//           offset: Offset(x, top - 12),
//           style: numberStyle,
//         );
//       }
//
//       canvas.drawLine(
//         Offset(x, top),
//         Offset(x, size.height),
//         Paint()
//           ..color = Colors.white
//           ..strokeWidth = 2
//           ..strokeCap = StrokeCap.round,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant ClockPainter oldDelegate) {
//     return true;
//   }
// }
