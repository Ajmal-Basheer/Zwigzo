import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/DeliveryPartner/OrderHistory.dart';
import 'package:foodapp/DeliveryPartner/PartnerInsights.dart';
import 'package:foodapp/DeliveryPartner/PartnerPayOut.dart';
import 'package:foodapp/Admin/Order/AdminOrderDetails.dart';
import 'package:foodapp/DeliveryPartner/PartnerProfile.dart';
import 'package:foodapp/Screens/Order/orderDetails.dart';
import 'package:foodapp/Screens/Profile/Profile.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class deliveryHome extends StatefulWidget {
  final User user;
  deliveryHome({required this.user});
  @override
  deliveryHomeState createState() => deliveryHomeState();
}
class deliveryHomeState extends State<deliveryHome> {
  String ? statusdropdownValue;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userData;
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      DocumentSnapshot userData = await _firestore.collection('partners').doc(widget.user.uid).get();
      if (userData.exists && userData.data() != null) {
        setState(() {
          _userData = userData.data() as Map<String, dynamic>;
        });
      } else {
        print('User data does not exist or is null.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  Future<void> _logout() async {
    try {
      await FirebaseFirestore.instance
          .collection('partners')
          .doc(currentUser!.uid)
          .update({'status': 'Offline'});
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print("Error logging out: $e");
    }
  }
  void updatePartnerStatus(String newStatus) async {
    try {
      String currentUserID = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('partners').doc(currentUserID).update({
        'status': newStatus,
      });
      print('Status updated successfully!');
    } catch (e) {
      print('Error updating status: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: scaffoldBackgroundColor,
     appBar: AppBar(
       backgroundColor: primaryColor,
       title: Row(
         children: [
           Text('Zwigzo',style: GoogleFonts.lato(fontWeight: FontWeight.w900,fontSize: 25),),
           Text('Partner',style: GoogleFonts.abel(fontWeight: FontWeight.w900,fontSize: 10,letterSpacing: 2),),
         ],
       ),
       actions: [
         Padding(
           padding: EdgeInsets.only(right: 10),
           child:StreamBuilder<DocumentSnapshot>(
               stream: FirebaseFirestore.instance.collection('partners').doc(currentUser!.uid).snapshots(),
               builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                 if (snapshot.hasError) {
                   return Text('Error: ${snapshot.error}');
                 }

                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return CircularProgressIndicator();
                 }

                 if (!snapshot.hasData || snapshot.data == null) {
                   return Text('No data available');
                 }

                 String currentStatus = snapshot.data!.get('status');

                 return DropdownButton<String>(
                     hint: Text(
                       currentStatus != null ? '--- $currentStatus ---' : '--- Status ---',
                       style: TextStyle(color: Colors.black),
                     ),
                 value: statusdropdownValue,
                 onChanged: (String? newValue) {
                   setState(() {
                     statusdropdownValue = newValue!;
                     updatePartnerStatus(newValue!);
                   });
                 },
                 icon: Icon(Icons.arrow_drop_down),
                 iconSize: 24,
                 elevation: 16,
                 style: TextStyle(color: Colors.black),
                 underline: Container(
                   height: 2,
                   color: Colors.black26,
                 ),
                 items: <String>['Active','Offline','On Delivery']
                     .map<DropdownMenuItem<String>>((String value) {
                   return DropdownMenuItem<String>(
                     value: value,
                     child: Text(
                       value,
                       style: TextStyle(color: Colors.black),
                     ),
                   );
                 }).toList(),
               );
             }
           ),
         ),
       ],
     ),
     drawer: Container(
       width: MediaQuery.of(context).size.width-130,
       color: Colors.white,
       child:  _userData == null
           ? Center(child: CircularProgressIndicator()):
       Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Column(
                         children: [
                           Padding(
                             padding: EdgeInsets.only(left: 20,top: 5),
                             child: Text('${_userData!['username']}'
                               , style: GoogleFonts.notoSansAdlam(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                           ),
                           Padding(
                             padding: EdgeInsets.only(left: 20,top: 5,bottom: 10),
                             child: Container(
                               padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                               decoration: BoxDecoration(
                                 color: _userData!['status'] == 'Active' ? Colors.green :
                                 _userData!['status'] == 'On Delivery' ? Colors.orange :
                                 _userData!['status'] == 'Offline' ? Colors.red : Colors.black,
                                 borderRadius: BorderRadius.circular(20),
                               ),
                               child: Text('${_userData!['status']}',style: TextStyle(color: Colors.white,fontSize: 12),),
                             ),
                           ),
                   ]
                             ),
                ),
               Divider(height: 1,),
               Padding(
                 padding: const EdgeInsets.only(top: 5),
                 child: GestureDetector(
                   child: ListTile(title: Text('Profile',style: TextStyle(fontWeight: FontWeight.w600),),
                     leading: Icon(Icons.person,color: Colors.black54,),),
                   onTap: (){
                     Navigator.push(context,  PageRouteBuilder(
                       pageBuilder: (context, animation, secondaryAnimation) {
                         return partnerProfile();
                       },
                       transitionsBuilder: (context, animation, secondaryAnimation, child) {
                         const curve = Curves.easeInOut;

                         var scaleTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

                         var scaleAnimation = animation.drive(scaleTween);

                         return ScaleTransition(scale: scaleAnimation, child: child);
                       },
                       transitionDuration: Duration(milliseconds: 400),
                     ),
                     );
                   },
                 ),
               ),
               GestureDetector(
                 child: ListTile(title: Text('Order History',style: TextStyle(fontWeight: FontWeight.w600),),
                   leading: Icon(Icons.timelapse,color: Colors.black54,),),
                 onTap: (){
                   Navigator.push(context,  PageRouteBuilder(
                     pageBuilder: (context, animation, secondaryAnimation) {
                       return OrderHistory();
                     },
                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                       const curve = Curves.easeInOut;

                       var scaleTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

                       var scaleAnimation = animation.drive(scaleTween);

                       return ScaleTransition(scale: scaleAnimation, child: child);
                     },
                     transitionDuration: Duration(milliseconds: 400),
                   ),
                   );
                 }, ),
               GestureDetector(
                   child: ListTile( title: Text('Insights',style: TextStyle(fontWeight: FontWeight.w600),),
                     leading: Icon(Icons.bar_chart,color: Colors.black54,),
                   ), onTap: (){
                 Navigator.push(context,  PageRouteBuilder(
                   pageBuilder: (context, animation, secondaryAnimation) {
                     return PartnertInsight();
                   },
                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
                     const curve = Curves.easeInOut;

                     var scaleTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

                     var scaleAnimation = animation.drive(scaleTween);

                     return ScaleTransition(scale: scaleAnimation, child: child);
                   },
                   transitionDuration: Duration(milliseconds: 400),
                 ),
                 );
               } ),
               GestureDetector(
                   child: ListTile( title: Text('Payout',style: TextStyle(fontWeight: FontWeight.w600),),
                     leading: Icon(Icons.monetization_on,color: Colors.black54,),
                   ), onTap: (){
                 Navigator.push(context,  PageRouteBuilder(
                   pageBuilder: (context, animation, secondaryAnimation) {
                     return PartnerPayout();
                   },
                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
                     const curve = Curves.easeInOut;

                     var scaleTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

                     var scaleAnimation = animation.drive(scaleTween);

                     return ScaleTransition(scale: scaleAnimation, child: child);
                   },
                   transitionDuration: Duration(milliseconds: 400),
                 ),
                 );
               } ),
               GestureDetector(
                   child: ListTile( title: Text('Help & support',style: TextStyle(fontWeight: FontWeight.w600),),
                     leading: Icon(Icons.help_outline,color: Colors.black54,),
                   ), onTap: (){} ),
               GestureDetector(
                   child: ListTile( title: Text('Logout',style: TextStyle(fontWeight: FontWeight.w600),),
                     leading: Icon(Icons.exit_to_app,color: Colors.black54,),
                   ), onTap: (){
                 _logout();
               } ),
               Container(
                 height: 1,
                 width: MediaQuery.of(context).size.width,
                 color: Colors.black12,),
             ],
           )
     ),
     body: SafeArea(
         child: Column(
           children: [
             Container(
                 alignment: Alignment.topLeft,
                 padding: EdgeInsets.only(left: 20,top: 10),
                 child: Text('Orders',style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold),)),
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
                       children: orders.map((DocumentSnapshot<Map<
                           String,
                           dynamic>> order) {
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
                                       offset: Offset(1, 3)
                                   )
                                 ]
                             ),
                             child:
                             StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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

                                   return Container(
                                     child: Row(
                                         crossAxisAlignment: CrossAxisAlignment
                                             .center,
                                         children: [
                                           Expanded(
                                             child: Padding(
                                               padding: const EdgeInsets.all(5),
                                               child: Column(
                                                 children: [
                                                   Row(
                                                     crossAxisAlignment: CrossAxisAlignment
                                                         .start,
                                                     mainAxisAlignment: MainAxisAlignment
                                                         .start,
                                                     children: [
                                                       Padding(
                                                         padding: const EdgeInsets
                                                             .only(right: 10),
                                                         child: Text('${orderData['quantity']} x',
                                                           style: GoogleFonts
                                                               .roboto(
                                                               fontSize: 18),),
                                                       ),
                                                       Expanded(
                                                         child: Container(
                                                           child: Text(
                                                             orderData['itemName'],
                                                             style: GoogleFonts
                                                                 .roboto(
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
                                                               BorderRadius.circular(10),
                                                               border: Border.all(
                                                                 color: Colors.blue,
                                                                 width: 1,
                                                               )),
                                                           child: Text(
                                                             orderData['rupees'].toString(),
                                                             style: TextStyle(
                                                                 color: Colors.blue),
                                                           ),
                                                         ),
                                                       ),
                                                     ],
                                                   ),
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
                                           ),
                                           Container(
                                             child: Dash(
                                                 direction: Axis.vertical,
                                                 length: 120,
                                                 dashLength: 15,
                                                 dashColor: Colors.grey
                                                     .shade400),
                                           ),
                                           Expanded(
                                             child: Padding(
                                               padding: const EdgeInsets
                                                   .fromLTRB(10, 10, 0, 10),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment
                                                     .start,
                                                 children: [
                                                   Text(
                                                     orderData['userName'],
                                                     style: TextStyle(
                                                         fontWeight: FontWeight.bold,
                                                         fontSize: 16),
                                                   ),
                                                   Text(orderData['address']),
                                                   Text(orderData['pinNumber']),
                                                   Text(orderData['district']),
                                                   Text(orderData['phoneNumber']),
                                                 ],
                                               ),
                                             ),
                                           ),
                                         ]),
                                   );
                                 }
                             ),
                           ),
                           onTap: () {
                             Navigator.push(context,  PageRouteBuilder(
                               pageBuilder: (context, animation, secondaryAnimation) {
                                 return AdminOrderDetails(OrderId: order['orderId'],);
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
                         );
                       }).toList());
                 }
            ),
           ],
         )
     ),
   );
  }
}
