import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Payment/Payment.dart';
import 'package:foodapp/config/Timeline.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/Timer.dart';

class AdminOrderDetails extends StatefulWidget {
  final String OrderId;
  AdminOrderDetails({required this.OrderId});
  @override
  State<StatefulWidget> createState() => AdminOrderDetailsState(
      OrderId : OrderId,
  );
}
class AdminOrderDetailsState extends State<AdminOrderDetails> {
  final String OrderId;
  AdminOrderDetailsState({
    required this.OrderId,
  });

  String ? firstdropdownValue;
  String ? seconddropdownValue;
  String ? Payment;

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      // Fetch the current order status
      DocumentSnapshot<Map<String, dynamic>> orderSnapshot =
      await FirebaseFirestore.instance.collection('orders').doc(orderId).get();

      if (!orderSnapshot.exists) {
        print('Order with ID $orderId does not exist.');
        return;
      }

      String currentStatus = orderSnapshot.data()!['OrderStatus'];

      // Delete the document from the appropriate collection if changing from specific statuses
      if ((currentStatus == "Accepted" || currentStatus == "Delivering Soon") &&
          (status != "Accepted" && status != "Delivering Soon")) {
        await FirebaseFirestore.instance
            .collection('ActiveOrders')
            .doc(orderId)
            .delete();
      } else if (currentStatus == "Cancelled") {
        await FirebaseFirestore.instance
            .collection('CancelledOrders')
            .doc(orderId)
            .delete();
      } else if (currentStatus != "Accepted" && currentStatus != "Delivering Soon") {
        await FirebaseFirestore.instance
            .collection('PlacedOrders')
            .doc(orderId)
            .delete();
      }

      // Update the order status in the "orders" collection
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
        'OrderStatus': status,
      });

      // Add the order to the appropriate collection based on the new status
      if (status == "Accepted" || status == "Delivering Soon") {
        await FirebaseFirestore.instance
            .collection('ActiveOrders')
            .doc(orderId)
            .set({
          'orderId': orderId,
        });
      } else if (status == "Cancelled") {
        await FirebaseFirestore.instance
            .collection('CancelledOrders')
            .doc(orderId)
            .set({
          'orderId': orderId,
        });
      } else {
        await FirebaseFirestore.instance
            .collection('PlacedOrders')
            .doc(orderId)
            .set({
          'orderId': orderId,
        });
      }

      print('Order status updated successfully.');
    } catch (e) {
      print('Error updating order status: $e');
    }
  }


  Future<void> updatePaymentMethod(String orderId, String paymentMethod) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({
        'paymentmethod': paymentMethod,
      });
      print('Payment method updated successfully.');
    } catch (e) {
      print('Error updating payment method: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Order Details', style: GoogleFonts.jost(fontSize: 20),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .doc(OrderId)
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3.6,
                                child: Image.network(orderData['itemImagelink']),   ),),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(orderData['itemName'],
                                  style: GoogleFonts.fjallaOne(fontSize: 18,),
                                ),
                                Text('Qty : ${orderData['quantity']}', style: GoogleFonts.poppins(),),

                                SizedBox(height: 5),
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
                                      padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                      child: Container(
                                        padding:  EdgeInsets.fromLTRB(10, 2, 10, 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.blue,width: 1,)
                                        ),
                                        child: Text('₹ ${orderData['rupees']}',style: TextStyle(color: Colors.blue),),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(30, 20, 10, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(orderData['userName'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              Text(orderData['address']),
                              Text(orderData['pinNumber']),
                              Text(orderData['district']),
                              Text(orderData['phoneNumber']),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: Container(
                              padding:  EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blue,width: 1,)
                              ),
                                child: Text('View Location',style: TextStyle(color: Colors.blue),),
                              )
                          ),
                          onTap: (){
                            _launchURL();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    padding: EdgeInsets.fromLTRB(30, 0, 130, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child:DropdownButton<String>(
                      hint: Text(
                        orderData['OrderStatus'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      value: firstdropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          firstdropdownValue = newValue!;
                        });
                        if(newValue =='Placed'){
                          newValue = 'Delivered';
                        }
                        updateOrderStatus(OrderId, newValue!);
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.grey[400],
                      ),
                      items: <String>['Accepted','Cancelled','Delivering Soon', 'Placed']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    padding: EdgeInsets.fromLTRB(30, 0, 130, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      hint: Text(
                        orderData['paymentmethod'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      value: seconddropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          seconddropdownValue = newValue!;
                        });
                        if(newValue == 'Recieved'){
                          Payment = 'PAID';
                        } else if(newValue == 'Online') {
                          Payment = 'Online';
                        }else{
                          Payment = 'Cash On Delivery';
                        }
                        updatePaymentMethod(OrderId, Payment!);
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.grey[400],
                      ),
                      items: <String>['Online','Recieved','Cash On Delivery']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
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
                          child: orderData['OrderStatus'] == 'Delivering Soon' ? TimerPage() : SizedBox(),
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
                ),
                SizedBox(height: 30,)
              ],
            );
          }
        ),
      ),
    );
  }
  _launchURL() async {
    const url = 'https://maps.app.goo.gl/edifXJC7rHQAuxAUA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}