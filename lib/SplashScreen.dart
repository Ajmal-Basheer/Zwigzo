import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/SignIn/Signin.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserSignIn();
  }
  void checkUserSignIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(seconds: 2));
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/Zwigzo_logo.png',width: 160,),
            SizedBox(height: 5),
            Text(
              'OUR TRUST MAKE YOUR TASTE',
              style: GoogleFonts.teko(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
