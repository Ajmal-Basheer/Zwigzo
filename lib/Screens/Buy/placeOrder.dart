import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Buy/successOrder.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class placeorder extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>placeorderState();
}
class placeorderState extends State {  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: scaffoldBackgroundColor,
    appBar: AppBar(
      backgroundColor: primaryColor,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          child: Container(
                            child: Icon(Icons.done_outline_sharp,color: Colors.white,size: 12,),
                          ),
                        ),
                        Text('Address',style: TextStyle(fontSize: 12,color: Colors.black),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width/6,
                        height: 2,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          child: Container(
                            child: Icon(Icons.done_outline_sharp,color: Colors.white,size: 12,),
                          ),
                        ),
                        Text('Payment',style: TextStyle(fontSize: 12,color: Colors.black),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width/6,
                        height: 2,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        ),
                        Text('Place Order',style: TextStyle(fontSize: 12,color: Colors.black),)
                      ],
                    ),
                  ]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              'Order Now',
              style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Container(
                width: MediaQuery.of(context).size.width-40,
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: .1,
                      color: Colors.black,
                    ),
                  ]),

              child: Column(
                children: [
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('items : ',),
                          Text('₹ 150',),
                        ],
                      )),
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('delivery : ',),
                          Text('₹ 0',),
                        ],
                      )),
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('total : ',),
                          Text('₹ 150',),
                        ],
                      )),
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order Total : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          Text('₹ 150',),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Container(
              width: MediaQuery.of(context).size.width-40,
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: .1,
                      color: Colors.black,
                    ),
                  ]),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery To : ',),
                  Text('Ajmal Basheer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                  Text('Valiyavila puthen veedu kampalady Poruvazhy po,kollam,690520',),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Container(
              width: MediaQuery.of(context).size.width-40,
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: .1,
                      color: Colors.black,
                    ),
                  ]),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment : ',),
                  Text('Cash On Delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: ElevatedButton(
              child: Text('Place Order', style: GoogleFonts.heebo(
                  color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(primaryColor),
                fixedSize:
                MaterialStateProperty.all<Size>(Size(MediaQuery
                    .of(context)
                    .size
                    .width - 40, 50)),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessPopUp()));
              },
            ),
          )
        ],
      ),
    ),
  );
}
}
