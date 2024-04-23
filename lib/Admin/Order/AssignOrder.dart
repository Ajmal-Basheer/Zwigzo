import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'newOrder.dart';

class AssignOrder extends StatefulWidget {
  final String OrderId;
  AssignOrder({required this.OrderId});
  @override
  State<StatefulWidget> createState() => AssignOrderState(
    OrderId: OrderId,
  );
}

class AssignOrderState extends State<AssignOrder> {
  final String OrderId;
  AssignOrderState({
    required this.OrderId,
  });
  String? dropdownValuePinNumber;
  String? dropdownValuePartner;
  List<String> partnerList = [];

  void assignOrder() {
    if (dropdownValuePartner != null) {
      addOrderToUserOrders(OrderId);
    } else {
      print('No partner selected');
    }
  }

  Future<void> addOrderToUserOrders(String orderId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> partnerSnapshot =
      await FirebaseFirestore.instance
          .collection('partners')
          .where('username', isEqualTo: dropdownValuePartner)
          .limit(1)
          .get();

      if (partnerSnapshot.docs.isNotEmpty) {
        String partnerId = partnerSnapshot.docs[0].id;

        CollectionReference<Map<String, dynamic>> userOrdersCollection =
        FirebaseFirestore.instance
            .collection('partners')
            .doc(partnerId)
            .collection('Orders');

        await userOrdersCollection.add({
          'orderId': orderId,
        });
        print('Order added to userOrders successfully!');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>newOrder()));
      } else {
        print('Partner not found');
      }
    } catch (e) {
      print('Error adding order to userOrders: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Assign Order',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Order Details
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Order Details',
                style: GoogleFonts.dmSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.black12,
                    offset: Offset(1, 3),
                  )
                ],
              ),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .doc(OrderId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  }

                  // Access the order data
                  Map<String, dynamic> orderData = snapshot.data!.data()!;

                  // Display order details
                  return Container(
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
                                      child: Text(
                                        '${orderData['quantity']} x',
                                        style: GoogleFonts.roboto(fontSize: 18),
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
                                      padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: orderData['paymentmethod'] == 'Cash On Delivery'
                                                ? Colors.red
                                                : Colors.green,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          orderData['paymentmethod'] == 'Cash On Delivery' ? 'CASH' : 'PAID',
                                          style: TextStyle(
                                              color: orderData['paymentmethod'] == 'Cash On Delivery'
                                                  ? Colors.red
                                                  : Colors.green),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 1,
                                            )),
                                        child: Text(
                                          '₹ ${orderData['rupees']}',
                                          style: TextStyle(color: Colors.blue),
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
                                  orderData['userName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(orderData['address']),
                                Text(orderData['pinNumber']),
                                Text(orderData['district']),
                                Text(orderData['phoneNumber']),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Select Delivery Partner
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Select Delivery Partner',
                style: GoogleFonts.dmSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Pin Number Dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValuePinNumber = newValue;
                      fetchPartnersByPin(newValue);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Pin Number',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Partner Dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      '---Select Partner---',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    value: dropdownValuePartner,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValuePartner = newValue!;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey[400],
                    ),
                    items: partnerList
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ElevatedButton(
                onPressed: () {
                  assignOrder();
                },
                child: Text('Assign Order',
                    style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(primaryColor),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width - 40, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> fetchPartnersByPin(String pinNumber) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('partners')
          .where('pinNumber', isEqualTo: pinNumber)
          .where('status', isEqualTo: 'Active')
          .get();

      List<String> partners = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
      doc['username'] as String)
          .toList();

      setState(() {
        partnerList = partners;
        dropdownValuePartner = null;
      });
    } catch (e) {
      print('Error fetching partners: $e');
    }
  }
}
