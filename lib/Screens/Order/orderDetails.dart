import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/config/Timeline.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../config/Timer.dart';

class orderDetails extends StatefulWidget {
  final String orderId;
  orderDetails({
    required this.orderId,
  });
  @override
  State<StatefulWidget> createState() =>orderDetailsState(
    orderId:orderId,
  );
}
class orderDetailsState extends State<orderDetails> {
  final String orderId;
  orderDetailsState({
    required this.orderId,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Order Details',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon : Icon (Icons.shopping_cart,color: Colors.black87),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .doc(orderId) // Reference to the specific order document
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<
                    DocumentSnapshot<
                        Map<String, dynamic>>>
                snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator());
              }

              if (!snapshot.hasData ||
                  snapshot.data == null) {
                return Center(
                    child: Text('No data available'));
              }

              // Access the order data
              Map<String, dynamic> orderData =
              snapshot.data!.data()!;

              // Display order details
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                    ),
                    child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                            child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width/3.6,
                                child: Image.network(orderData['itemImagelink'])),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                  Text(orderData['itemName'],
                                    style: GoogleFonts.fjallaOne(fontSize: 18,),
                                  ),
                              Text('Qty : ${orderData['quantity']}',style:GoogleFonts.poppins(),),

                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text('₹',style: TextStyle(color: primaryColor,fontSize: 20),),
                                  ),
                                  Text(orderData['rupees'].toString(),style: GoogleFonts.notoSans(fontSize: 22,fontWeight: FontWeight.bold,color: primaryColor),),
                                ],
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        ),

                    child: Column(
                      children: [
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('items : ',),
                                Text('₹ ${orderData['rupees']}',),
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
                                Text('₹ ${orderData['rupees']}',),
                              ],
                            )),
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Order Total : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Text('₹ ${orderData['rupees']}',),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment : ',),
                        Text(orderData['paymentmethod'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      ],
                    ),
                  ),
                ),
                orderData['OrderStatus']!="Cancelled" ?
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                       ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: TimerPage()
                        ),
                        timeLine(isFirst: true,
                            isLast: false,
                            isPast: true,
                          eventCard:Text('Order Placed',style: GoogleFonts.abel(
                              fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),),),
                        timeLine(isFirst: false,
                            isLast: false,
                          isPast: orderData['OrderStatus'] == 'Delivering Soon' || orderData['OrderStatus'] == 'Delivered' ? true : false,
                          eventCard:Text('Out For Delivery',style: GoogleFonts.abel(
                              fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),),),
                        timeLine(
                          isFirst: false,
                          isLast: true,
                          isPast: orderData['OrderStatus'] == 'Delivered' ? true : false,
                          eventCard: Text("Delivered",style: GoogleFonts.abel(
                              fontSize: 15,fontWeight: FontWeight.bold,color:  orderData['OrderStatus'] == 'Delivered' ?Colors.green: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) :  Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CancelledtimeLine(isFirst: true,
                          isLast: false,
                          isPast: true,
                          eventCard:Text('Order Placed',style: GoogleFonts.abel(
                              fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),),),
                        CancelledtimeLine(
                          isFirst: false,
                          isLast: true,
                          isPast:  true,
                          eventCard: Text("Cancelled",style: GoogleFonts.abel(
                              fontSize: 15,fontWeight: FontWeight.bold,color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
