import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Buy/failedOrder.dart';
import 'package:foodapp/Screens/Buy/successOrder.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/loading.dart';
import '../../config/noItemFound.dart';

class placeorder extends StatefulWidget {
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double? totalprize;
  int? quantity;
  final String paymentMethod;

  placeorder({
    required this.categoryDoc,
    required this.selectedItemID,
    required this.categoryName,
    required this.totalprize,
    required this.quantity,
    required this.paymentMethod,
  });

  @override
  placeorderState createState() => placeorderState(
        categoryName: categoryName,
        categoryDoc: categoryDoc,
        selectedItemID: selectedItemID,
        totalprize: totalprize,
        quantity: quantity,
        paymentMethod: paymentMethod,
      );
}

class placeorderState extends State {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }
  Future<void> addOrderDetails() async {
    CollectionReference<Map<String, dynamic>> itemsCollection =
    FirebaseFirestore.instance.collection('orders');

    Stream<DocumentSnapshot<Map<String, dynamic>>> itemStream =
    _fetchItemDetailsStream(selectedItemID);

    // Wait for the item details snapshot
    DocumentSnapshot<Map<String, dynamic>> itemSnapshot =
    await itemStream.first;

    if (!itemSnapshot.exists) {
      print('Item data not found.');
      return;
    }

    Map<String, dynamic> itemData = itemSnapshot.data()!;
    try {
      DocumentSnapshot<Object?> userSnapshot =
      await users.doc(_user!.uid).get();
      if (!userSnapshot.exists) {
        print('User data not found.');
        return;
      }
      DocumentSnapshot userData = await users.doc(_user?.uid).get();

      // Generate a unique orderId
      String orderId = itemsCollection.doc().id;

      await itemsCollection.doc(orderId).set({
        'userId': _user!.uid,
        'userName': userData['username'],
        'address': userData['address'],
        'pinNumber': userData['pinNumber'],
        'district': userData['district'],
        'phoneNumber': userData['phoneNumber'],
        'itemCategory': categoryName,
        'itemName': itemData['itemName'],
        'itemImagelink':itemData['itemImagelink'],
        'rupees': totalprize,
        'quantity': quantity,
        'paymentmethod': paymentMethod,
        'itemId': selectedItemID,
        'categoryId': categoryDoc,
        'OrderStatus':'Ordered',
      });
      print('Data added successfully to orders!');
      // Add the orderId to userOrders
      await addOrderToUserOrders(orderId);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessPopUp()),
      );
    } catch (e) {
      print('Error adding data: $e');
      Navigator.push(context, MaterialPageRoute(builder: (context) => failedPop()));
    }
  }

  Future<void> addOrderToUserOrders(String orderId) async {
    try {
      CollectionReference<Map<String, dynamic>> userOrdersCollection =
      FirebaseFirestore.instance.collection('users')
          .doc(_user!.uid)
          .collection('userOrders');

      await userOrdersCollection.add({
        'orderId': orderId,
      });

      print('Order added to userOrders successfully!');
    } catch (e) {
      print('Error adding order to userOrders: $e');
    }
  }

  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  final String paymentMethod;
  double? totalprize;
  int? quantity;

  placeorderState({
    required this.categoryDoc,
    required this.selectedItemID,
    required this.categoryName,
    required this.totalprize,
    required this.quantity,
    required this.paymentMethod,
  });



  @override
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
                              child: Icon(
                                Icons.done_outline_sharp,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          Text(
                            'Address',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 6,
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
                              child: Icon(
                                Icons.done_outline_sharp,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          Text(
                            'Payment',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 6,
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
                          Text(
                            'Place Order',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ),
                    ]),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(
                'Order Now',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: _fetchItemDetailsStream(selectedItemID),
                // Fetch item details based on selected ID
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: loading(),
                    );
                  }
                  Map<String, dynamic> itemData = snapshot.data!.data()!;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
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
                              Text(
                                'item Category: ',
                              ),
                              Text(categoryName),
                            ],
                          )),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'item name : ',
                              ),
                              Text(
                                itemData['itemName'],
                              ),
                            ],
                          )),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'quantity',
                              ),
                              Text(
                                quantity.toString(),
                              ),
                            ],
                          )),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rupees per one : ',),
                              Text(
                                itemData['rupees'],
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                   );
              }
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
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
                        Text(
                          'items : ',
                        ),
                        Text(
                          '₹${totalprize}',
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'delivery : ',
                        ),
                        Text(
                          '₹ 0',
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'total : ',
                        ),
                        Text(
                          '₹ ${totalprize}',
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Total : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '₹ ${totalprize}',
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: users.doc(_user!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    print('No user data found.');
                  }
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
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
                          Text(
                            'Delivery To : ',
                          ),
                          Text(userData['username'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(
                            '${userData['address']},${userData['district']},${userData['pinNumber']}\n${userData['phoneNumber']}',
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
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
                    Text(
                      'Payment : ',
                    ),
                    Text(paymentMethod,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: ElevatedButton(
                child: Text('Place Order',
                    style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width - 40, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                 addOrderDetails();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> _fetchItemDetailsStream(String itemID) {
    CollectionReference<Map<String, dynamic>> itemsCollection =
    FirebaseFirestore.instance.collection('foodCategory');
    return itemsCollection.doc(categoryDoc).collection(categoryName + 'Items').doc(itemID).snapshots();
  }
}
