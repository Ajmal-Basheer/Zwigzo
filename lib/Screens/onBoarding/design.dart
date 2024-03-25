import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/onBoarding/Model.dart';
import 'package:foodapp/SignIn/Signin.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class onBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => onboardstate();
}

class onboardstate extends State<onBoarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFE06567),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int Index) {
                  setState(() {
                    currentIndex = Index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          contents[i].image,
                          repeat: false,
                        ),
                        Text(
                          contents[i].title,
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500)),
                        ),
                        Text(
                          contents[i].description,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                    (index) => buildDot(index),
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Signin()));
                }
                _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                currentIndex == contents.length - 1 ? 'Continue' : 'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 15 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: primaryColor),
    );
  }
}