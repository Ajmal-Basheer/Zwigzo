import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Buy/newAddress.dart';
import 'package:foodapp/Screens/Payment/Payment.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class address extends StatefulWidget {
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double? totalprize;
  int ? quantity;

  address(
      {required this.categoryDoc,
      required this.selectedItemID,
      required this.categoryName,
      required this.totalprize,
      required this.quantity,
      });

  @override
  addressState createState() => addressState(
        categoryName: categoryName,
        categoryDoc: categoryDoc,
        selectedItemID: selectedItemID,
        totalprize: totalprize,
        quantity : quantity,
      );
}

class addressState extends State<address> {
  int selectedValue = 1;
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double? totalprize;
  int? quantity;

  addressState(
      {required this.categoryDoc,
      required this.selectedItemID,
      required this.categoryName,
      required this.totalprize,
      required this.quantity,
      });

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

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
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(children: [
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          width: 8,
                          height: 8,
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
                      color: Color(0x56fdd301),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x56fdd301),
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
                        'Payment',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 6,
                      height: 2,
                      color: Color(0x56fdd301),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x56fdd301),
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
                        style: TextStyle(fontSize: 12, color: Colors.black54),
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
            'Select a delivery address',
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as int;
                        });
                      },
                    ),
                    StreamBuilder(
                        stream: users.doc(_user!.uid).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            print('No user data found.');
                          }
                          final userData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData['username'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(userData['address']),
                                Text(userData['pinNumber']),
                                Text(userData['district']),
                                Text(userData['phoneNumber']),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
        // ElevatedButton(
        //   child: Text('Edit Address',
        //       style: GoogleFonts.heebo(
        //           color: Colors.black,
        //           fontSize: 12,
        //           fontWeight: FontWeight.bold)),
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
        //     fixedSize: MaterialStateProperty.all<Size>(
        //         Size(MediaQuery.of(context).size.width - 40, 50)),
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //       RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //       ),
        //     ),
        //   ),
        //   onPressed: () {},
        // ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
        //   child: ElevatedButton(
        //     child: Text('Add New Address',
        //         style: GoogleFonts.heebo(
        //             color: Colors.black,
        //             fontSize: 12,
        //             fontWeight: FontWeight.bold)),
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
        //       fixedSize: MaterialStateProperty.all<Size>(
        //           Size(MediaQuery.of(context).size.width - 40, 50)),
        //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //       ),
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         PageRouteBuilder(
        //           pageBuilder: (context, animation, secondaryAnimation) {
        //             return newAddress();
        //           },
        //           transitionsBuilder:
        //               (context, animation, secondaryAnimation, child) {
        //             const begin = Offset(1.0, 0.0);
        //             const end = Offset.zero;
        //             const curve = Curves.easeInOut;
        //
        //             var tween = Tween(begin: begin, end: end)
        //                 .chain(CurveTween(curve: curve));
        //
        //             var offsetAnimation = animation.drive(tween);
        //
        //             return SlideTransition(
        //                 position: offsetAnimation, child: child);
        //           },
        //           transitionDuration: Duration(milliseconds: 400),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            child: Text('Deliver to this address',
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return payment(categoryDoc: categoryDoc,categoryName: categoryName,selectedItemID: selectedItemID,
                      totalprize: totalprize, quantity: quantity,
                    );
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
          ),
        )
      ])),
    );
  }
}
//0x56fdd301
