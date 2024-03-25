import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/TimelineEvent.dart';
import 'package:foodapp/config/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class timeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final  eventCard;
  const timeLine ({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.eventCard,
});
  @override
  Widget build(BuildContext context) {
   return SizedBox(
     height: 110,
     child: TimelineTile(
       isFirst: isFirst,
       isLast: isLast,
       beforeLineStyle: LineStyle(color: isPast ?  primaryColor : Color(
           0xfffff2b1)),
       indicatorStyle: IndicatorStyle(width: 20,
       color: isPast ? primaryColor : Color(0xfffff2b1),
       iconStyle: IconStyle(iconData: Icons.done,
           fontSize: 15,
           color: isPast ? Colors.white : Color(0xfffff2b1)),
       ),
       endChild: eventChild(
         isPast: isPast,
         child: eventCard,
       ),
     ),
   );
  }
}class timeLineTwo extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final  eventCard;
  const timeLineTwo ({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.eventCard,
});
  @override
  Widget build(BuildContext context) {
   return SizedBox(
     height: 80,
     child: TimelineTile(
       isFirst: isFirst,
       isLast: isLast,
       beforeLineStyle: LineStyle(color: isPast ?  primaryColor : Color(
           0xfffff2b1)),
       indicatorStyle: IndicatorStyle(width: 20,
       color: isPast ? primaryColor : Color(0xfffff2b1),
       iconStyle: IconStyle(iconData: Icons.done,
           fontSize: 15,
           color: isPast ? Colors.white : Color(0xfffff2b1)),
       ),
       endChild: eventChild(
         isPast: isPast,
         child: eventCard,
       ),
     ),
   );
  }
}
