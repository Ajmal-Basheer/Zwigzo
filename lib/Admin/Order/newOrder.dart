import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/Admin/Order/AssignOrder.dart';
import 'package:foodapp/Admin/Order/AdminOrderDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class newOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => newOrderState();
}

class newOrderState extends State {
  String getDocumentId(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.id;
  }
  Future<void> cancelOrder(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(documentId)
          .update({
        'OrderStatus': 'Cancelled',
      });
      print('Order status updated successfully.');
    } catch (e) {
      print('Error updating order status: $e');
      throw e;
    }
  }
  Future<void> acceptOrder(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(documentId)
          .update({
        'OrderStatus': 'Accepted',
      });
      print('Order status updated successfully.');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignOrder(OrderId: documentId)));
    } catch (e) {
      print('Error updating order status: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                    children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'latest Orders',
                  style: GoogleFonts.dmSans(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  List<DocumentSnapshot<Map<String, dynamic>>> orders =
                      snapshot.data!.docs;


                  return Column(
                      children: orders
                          .map((DocumentSnapshot<Map<String, dynamic>> order) {
                    return GestureDetector(
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
                                  offset: Offset(1, 3))
                            ]),
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                '${order['quantity']} x',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  order['itemName'],
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
                                                        color:order['paymentmethod'] == 'Cash On Delivery' ? Colors.red : Colors.green,
                                                      width: 1,
                                                    )),
                                                child: Text(
                                                  order['paymentmethod'] == 'Cash On Delivery' ? 'CASH' : 'PAID',
                                                  style: TextStyle(
                                                      color:order['paymentmethod'] == 'Cash On Delivery' ? Colors.red : Colors.green),
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
                                                        BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                      width: 1,
                                                    )),
                                                child: Text(
                                                  order['rupees'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                       order['OrderStatus'] =='Ordered'  ? Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Are you sure to accept the order ?',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text('No'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              String documentId = getDocumentId(order);
                                                              acceptOrder(documentId);
                                                            },
                                                            child: Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Are you sure to reject the order ?',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            },
                                                            child: Text('No'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              String documentId = getDocumentId(order);
                                                              cancelOrder(documentId);// Close the dialog
                                                            },
                                                            child: Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color:
                                                                      Colors.red),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  'Reject',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        ) :  Padding(
                                         padding: EdgeInsets.fromLTRB(
                                             0, 10, 5, 0),
                                         child: Container(
                                           padding: EdgeInsets.fromLTRB(
                                               10, 2, 10, 2),
                                           decoration: BoxDecoration(
                                               borderRadius:
                                               BorderRadius.circular(10),
                                               border: Border.all(
                                                 color:order['OrderStatus'] == 'Cancelled' ? Colors.red : Colors.green,
                                                 width: 1,
                                               )),
                                           child: Text(
                                             order['OrderStatus'],
                                             style: TextStyle(
                                               color:order['OrderStatus'] == 'Cancelled' ? Colors.red : Colors.green,),
                                           ),
                                         ),
                                       ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Dash(
                                      direction: Axis.vertical,
                                      length: 120,
                                      dashLength: 15,
                                      dashColor: Colors.grey.shade400),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order['userName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(order['address']),
                                        Text(order['pinNumber']),
                                        Text(order['district']),
                                        Text(order['phoneNumber']),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      onTap: () {
                        String documentId = getDocumentId(order);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return AdminOrderDetails(OrderId: documentId);
                            },
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            },
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                    );
                  }).toList());
                })
                    ],
                  ),
          )),
    );
  }
}
