import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class noItemFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-100,
      child: Center(
        child: Container(
                 height: 150,
                 width: 150,
                 child: Lottie.network('https://lottie.host/115079a7-37a6-4e9a-9d00-efd23cccb964/tCKmU2KDD3.json'),
        ),
      ),
    );
  }
}
