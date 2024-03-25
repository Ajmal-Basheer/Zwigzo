import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class eventChild extends StatelessWidget {
  final bool isPast;
  final child;
  const eventChild ({
    super.key,
    required this.isPast,
    required this.child
});
  @override
  Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.yellow.shade200,
            Colors.white,
          ],
        ),
      borderRadius: BorderRadius.circular(10)
    ),
     margin: EdgeInsets.all(10),
     padding: EdgeInsets.all(10),
     child: child,
   );
  }
}
