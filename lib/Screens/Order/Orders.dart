import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Buy/address.dart';
import 'package:foodapp/Screens/Home.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/Screens/Order/orderDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyOrderState();
}

class MyOrderState extends State {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({
        'OrderStatus': 'Cancelled',
      });
      print('Order status updated successfully.');
    } catch (e) {
      print('Error updating order status: $e');
      throw e; // Rethrow the error for handling at the caller's level
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'My Order',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black87),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => cart()));
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_user!.uid)
              .collection('userOrders')
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

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> orderId =
                      snapshot.data!.docs[index].data()!;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  blurStyle: BlurStyle.normal,
                                  color: Colors.black12,
                                  offset: Offset(1, 4),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc(orderId[
                                      'orderId']) // Reference to the specific order document
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
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          orderData['itemImagelink'],
                                          height: 90,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              orderData['itemName'],
                                              style: GoogleFonts.fjallaOne(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Quantity: ${orderData['quantity'].toString()}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                            if (orderData['OrderStatus'] ==
                                                'Cancelled')
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  'Cancelled',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            else if (orderData['OrderStatus'] ==
                                                'Delivered')
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  orderData['OrderStatus'],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            else
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Text(
                                                      orderData['OrderStatus'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('Cancel'),
                                                            content: Text(
                                                                'Are you sure you want to Cancel?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('No'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  cancelOrder(
                                                                      orderId[
                                                                          'orderId']);
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('Yes'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return orderDetails(
                                                    orderId: orderId['orderId'],
                                                  );
                                                },
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  const begin =
                                                      Offset(1.0, 0.0);
                                                  const end = Offset.zero;
                                                  const curve =
                                                      Curves.easeInOut;

                                                  var tween = Tween(
                                                          begin: begin,
                                                          end: end)
                                                      .chain(CurveTween(
                                                          curve: curve));

                                                  var offsetAnimation =
                                                      animation.drive(tween);

                                                  return SlideTransition(
                                                      position: offsetAnimation,
                                                      child: child);
                                                },
                                                transitionDuration:
                                                    Duration(milliseconds: 400),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.arrow_forward)),
                                    ]);
                              }),
                        ),
                      ],
                    ),
                  );
                });
          }),
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return HomeScreen();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, -1.0);
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
          child: Text('Continue Shopping',
              style: GoogleFonts.heebo(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
            fixedSize: MaterialStateProperty.all<Size>(
                Size(MediaQuery.of(context).size.width - 20, 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
