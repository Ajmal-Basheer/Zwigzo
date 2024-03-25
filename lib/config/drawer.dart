import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Admin/AdminHome.dart';
import 'package:foodapp/DeliveryPartner/DeliveryHome.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/Screens/Items/Wishlist.dart';
import 'package:foodapp/Screens/Order/Orders.dart';
import 'package:foodapp/Screens/Profile/Profile.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class drawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => drawerState();
}
class drawerState extends State {
  late User? _user;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print("Error logging out: $e");
      // Handle error logging out user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 130,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2.2,
            color: primaryColor,
            child: StreamBuilder(
              stream: users.doc(_user!.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  print('No data available');
                  return Text('No data available');
                }

                Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        userData['username'],
                        style: GoogleFonts.notoSansAdlam(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        userData['phoneNumber'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                       ),
                     ),
                   ),
                 ],
               );
             },
         ),
         ),
         Padding(
           padding: const EdgeInsets.only(top: 20),
           child: GestureDetector(
             child: ListTile(
               title: Text(
                 'Profile',
                 style: TextStyle(fontWeight: FontWeight.w600),
               ),
               leading: Icon(
                 Icons.person,
                 color: Colors.black54,
               ),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 PageRouteBuilder(
                   pageBuilder: (context, animation, secondaryAnimation) {
                     return userProfile();
                   },
                   transitionsBuilder:
                       (context, animation, secondaryAnimation, child) {
                     const curve = Curves.easeInOut;

                     var scaleTween = Tween(begin: 0.0, end: 1.0)
                         .chain(CurveTween(curve: curve));

                     var scaleAnimation = animation.drive(scaleTween);

                     return ScaleTransition(
                         scale: scaleAnimation, child: child);
                   },
                   transitionDuration: Duration(milliseconds: 400),
                 ),
               );
             },
           ),
         ),
         GestureDetector(
           child: ListTile(
             title: Text(
               'My Order',
               style: TextStyle(fontWeight: FontWeight.w600),
             ),
             leading: Icon(
               Icons.fastfood,
               color: Colors.black54,
             ),
           ),
           onTap: () {
             Navigator.push(
               context,
               PageRouteBuilder(
                 pageBuilder: (context, animation, secondaryAnimation) {
                   return MyOrder();
                 },
                 transitionsBuilder:
                     (context, animation, secondaryAnimation, child) {
                   const curve = Curves.easeInOut;

                   var scaleTween = Tween(begin: 0.0, end: 1.0)
                       .chain(CurveTween(curve: curve));

                   var scaleAnimation = animation.drive(scaleTween);

                   return ScaleTransition(
                       scale: scaleAnimation, child: child);
                 },
                 transitionDuration: Duration(milliseconds: 400),
               ),
             );
           },
         ),
         GestureDetector(
           child: ListTile(
             title: Text(
               'Cart',
               style: TextStyle(fontWeight: FontWeight.w600),
             ),
             leading: Icon(
               Icons.shopping_cart,
               color: Colors.black54,
             ),
           ),
           onTap: () {
             Navigator.push(
               context,
               PageRouteBuilder(
                 pageBuilder: (context, animation, secondaryAnimation) {
                   return cart();
                 },
                 transitionsBuilder:
                     (context, animation, secondaryAnimation, child) {
                   const curve = Curves.easeInOut;

                   var scaleTween = Tween(begin: 0.0, end: 1.0)
                       .chain(CurveTween(curve: curve));

                   var scaleAnimation = animation.drive(scaleTween);

                   return ScaleTransition(
                       scale: scaleAnimation, child: child);
                 },
                 transitionDuration: Duration(milliseconds: 400),
               ),
             );
           },
         ),
         GestureDetector(
             child: ListTile(
               title: Text(
                 'Wishlist',
                 style: TextStyle(fontWeight: FontWeight.w600),
               ),
               leading: Icon(
                 Icons.favorite_border,
                 color: Colors.black54,
               ),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 PageRouteBuilder(
                   pageBuilder: (context, animation, secondaryAnimation) {
                     return wishlist();
                   },
                   transitionsBuilder:
                       (context, animation, secondaryAnimation, child) {
                     const curve = Curves.easeInOut;

                     var scaleTween = Tween(begin: 0.0, end: 1.0)
                         .chain(CurveTween(curve: curve));

                     var scaleAnimation = animation.drive(scaleTween);

                     return ScaleTransition(
                         scale: scaleAnimation, child: child);
                   },
                   transitionDuration: Duration(milliseconds: 400),
                 ),
               );
             }),
         GestureDetector(
             child: ListTile(
               title: Text(
                 'Help & support',
                 style: TextStyle(fontWeight: FontWeight.w600),
               ),
               leading: Icon(
                 Icons.help_outline,
                 color: Colors.black54,
               ),
             ),
             onTap: () {}),
         GestureDetector(
             child: ListTile(
               title: Text(
                 'Logout',
                 style: TextStyle(fontWeight: FontWeight.w600),
               ),
               leading: Icon(
                 Icons.exit_to_app,
                 color: Colors.black54,
               ),
             ),
             onTap: () {
               _logout();
             }),
         GestureDetector(
             child: ListTile(
               title: Text(
                 'Admin',
                 style: TextStyle(fontWeight: FontWeight.w600),
               ),
               leading: Icon(
                 Icons.exit_to_app,
                 color: Colors.black54,
               ),
             ),
             onTap: () {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => adminHome()));
             }),
         GestureDetector(
             child: ListTile(
               title: Text(
                 'Delivery partner',
                 style: TextStyle(fontWeight: FontWeight.w600),
               ),
               leading: Icon(
                 Icons.exit_to_app,
                 color: Colors.black54,
               ),
             ),
             onTap: () {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => deliveryHome()));
             }),
         Container(
           height: 1,
           width: MediaQuery.of(context).size.width,
           color: Colors.black12,
         ),
       ],
     ),
   );
  }
}
