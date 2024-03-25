import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminOrderHis extends StatefulWidget {  @override
State<StatefulWidget> createState() => AdminOrderHisState();
}
class AdminOrderHisState extends State {  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: scaffoldBackgroundColor,
    body: SafeArea(
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text('Order History',style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold),)),
            GestureDetector(
              child:Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          color: Colors.black12,
                          offset: Offset(1, 3)
                      )
                    ]
                ),
                child:
                Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text('1 x',style:GoogleFonts.roboto(fontSize: 18),),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          'Zwigzo Biriyani',
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
                                      child: Container(
                                        padding:  EdgeInsets.fromLTRB(10, 2, 10, 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.green,width: 1,)
                                        ),
                                        child: Text('PAID',style: TextStyle(color: Colors.green),),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                      child: Container(
                                        padding:  EdgeInsets.fromLTRB(10, 2, 10, 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.blue,width: 1,)
                                        ),
                                        child: Text('₹ 150',style: TextStyle(color: Colors.blue),),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container (
                          child: Dash(
                              direction: Axis.vertical,
                              length: 90,
                              dashLength: 10,
                              dashColor: Colors.grey.shade400),
                        ),
                        Expanded(
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ajmal Basheer',
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('8606070030'),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text('Delivered',style: TextStyle(color: Colors.white,fontSize: 12),),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              onTap: (){
                // Navigator.push(context,  PageRouteBuilder(
                //   pageBuilder: (context, animation, secondaryAnimation) {
                //     return partnerOrderDetails();
                //   },
                //   transitionsBuilder:
                //       (context, animation, secondaryAnimation, child) {
                //     const begin = Offset(1.0, 0.0);
                //     const end = Offset.zero;
                //     const curve = Curves.easeInOut;
                //
                //     var tween = Tween(begin: begin, end: end)
                //         .chain(CurveTween(curve: curve));
                //
                //     var offsetAnimation = animation.drive(tween);
                //
                //     return SlideTransition(position: offsetAnimation, child: child);
                //   },
                //   transitionDuration: Duration(milliseconds: 400),
                // ),
                // );
              },
            ),
          ],
        )
    ),
  );
}
}
