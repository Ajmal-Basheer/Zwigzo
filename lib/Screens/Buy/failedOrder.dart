import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Order/Orders.dart';
import 'package:lottie/lottie.dart';

class failedPop extends StatefulWidget {
  State<StatefulWidget> createState()=>failedPopState();
}
class failedPopState extends State<failedPop> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500), // Adjust duration as needed
    );

    _animationController.forward(); // Start the animation

    // Listen for animation completion
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, navigate to OrderPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyOrder()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/failed.json', // Replace with your Lottie file path
              width: MediaQuery.of(context).size.width/1.5,
              repeat: false,
              reverse: false,
            ),
          ],
        ),
      ),
    );
  }
}
