import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderHistoryState();
}

class OrderHistoryState extends State {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Order History',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Order History',
                style: GoogleFonts.dmSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              )),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('partners')
                  .doc(currentUser!.uid)
                  .collection('Orders')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Text('No orders found.');
                }
                List<DocumentSnapshot<Map<String, dynamic>>> orders =
                    snapshot.data!.docs;
                return Column(
                    children: orders
                        .map((DocumentSnapshot<Map<String, dynamic>> order) {
                  return Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              color: Colors.black12,
                              offset: Offset(1, 3))
                        ]),
                    child: Container(
                      child:StreamBuilder <DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('orders')
                              .doc(order['orderId'])
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      'Error: ${snapshot.error}'));
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
                            Map<String, dynamic> orderData =
                            snapshot.data!.data()!;

                            return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child:  Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 10),
                                              child: Text(
                                                '${orderData['quantity']} x',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  orderData['itemName'],
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
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 5, 0),
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 10, 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color:orderData['paymentmethod'] == 'Cash On Delivery' ? Colors.red : Colors.green,
                                                      width: 1,
                                                    )),
                                                child: Text(
                                                  orderData['paymentmethod'] == 'Cash On Delivery' ? 'CASH' : 'PAID',
                                                  style: TextStyle(
                                                      color:orderData['paymentmethod'] == 'Cash On Delivery' ? Colors.red : Colors.green),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 10, 0, 0),
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 10, 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                      width: 1,
                                                    )),
                                                child: Text(
                                                  '₹ ${orderData['rupees']}',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            Container(
                              child: Dash(
                                  direction: Axis.vertical,
                                  length: 90,
                                  dashLength: 10,
                                  dashColor: Colors.grey.shade400),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    orderData['userName'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(orderData['phoneNumber']),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 10, 5, 0),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          10, 2, 10, 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                            color:orderData['OrderStatus'] == 'Cancelled' ? Colors.red : Colors.green,
                                            width: 1,
                                          )),
                                      child: Text(
                                        orderData['OrderStatus'],
                                        style: TextStyle(
                                          color:orderData['OrderStatus'] == 'Cancelled' ? Colors.red : Colors.green,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                                    }
                                ),
                    ),
                  );
                }).toList());
              })
        ],
      )),
    );
  }
}
