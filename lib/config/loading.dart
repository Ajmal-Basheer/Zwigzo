import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:lottie/lottie.dart';

class loading extends StatelessWidget {  @override
  Widget build(BuildContext context) {
  return Center(
    child: Container(
      child:
      // Lottie.network(
      //     'https://lottie.host/3b664beb-ed72-41bb-8530-14fc995af298/CD7Gf2LYm5.json'),
      CircularProgressIndicator(
        color: primaryColor,
      ),
    ),
  );
}
}
class imageLoading extends StatelessWidget {  @override
Widget build(BuildContext context) {
  return Center(
    child: Container(
      width: 200,
      height: 200,
      child:
      Lottie.network(
          'https://lottie.host/c529922f-aff2-465c-94db-191f38d91b13/o1Gzf9pBwO.json'),
    ),
  );
}
}

