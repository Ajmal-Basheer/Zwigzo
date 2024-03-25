import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/Admin/Order/AssignOrder.dart';
import 'package:foodapp/DeliveryPartner/partnerOrderDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class newOrder extends StatefulWidget {  @override
  State<StatefulWidget> createState() => newOrderState();
}
class newOrderState extends State {  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: scaffoldBackgroundColor,
    body: SafeArea(
      child: Column(
          children: [
          Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20,top: 10),
          child: Text('latest Orders',style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold),)),
      GestureDetector(
        child: Container(
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
                                      border: Border.all(color: Colors.red,width: 1,)
                                  ),
                                  child: Text('CASH',style: TextStyle(color: Colors.red),),
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
                          Row(
                            children: [
                              TextButton(onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Are you sure to accept the order ?',style: TextStyle(fontSize: 20),),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: (){
                                            Navigator.push(context,  PageRouteBuilder(
                                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return  AssignOrder();
                                              },
                                              transitionsBuilder:
                                                  (context, animation, secondaryAnimation, child) {
                                                const begin = Offset(1.0, -0.0);
                                                const end = Offset.zero;
                                                const curve = Curves.easeInOut;

                                                var tween = Tween(begin: begin, end: end)
                                                    .chain(CurveTween(curve: curve));

                                                var offsetAnimation = animation.drive(tween);

                                                return SlideTransition(position: offsetAnimation, child: child);
                                              },
                                              transitionDuration: Duration(milliseconds: 400),
                                            ),
                                            );
                                          },
                                          child: Text('Yes',style: TextStyle(color: Colors.green),),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                                  child: Text('Accept',style: TextStyle(color: Colors.green),)),
                              TextButton(onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Are you sure to reject the order ?',style: TextStyle(fontSize: 20),),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: Text('Yes',style: TextStyle(color: Colors.red),),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                                  child: Text('Reject',style: TextStyle(color: Colors.red),))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container (
                    child: Dash(
                        direction: Axis.vertical,
                        length: 120,
                        dashLength: 15,
                        dashColor: Colors.grey.shade400),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ajmal Basheer',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text('Valiyavila puthen veedu'),
                          Text('690520'),
                          Text('kollam'),
                          Text('8606070030'),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        onTap: (){
          Navigator.push(context,  PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return partnerOrderDetails();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            transitionDuration: Duration(milliseconds: 400),
          ),
          );
        },
      ),
      ],
    )
    ),
  );
  }
}
