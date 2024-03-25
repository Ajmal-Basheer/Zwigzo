import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Admin/AdminHome.dart';
import 'package:foodapp/DeliveryPartner/DeliveryHome.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/Screens/Items/Categories%20details.dart';
import 'package:foodapp/Screens/Items/ItemDetails.dart';
import 'package:foodapp/Screens/Items/PopularItem.dart';
import 'package:foodapp/Screens/Items/Wishlist.dart';
import 'package:foodapp/Screens/Items/itemsList.dart';
import 'package:foodapp/Screens/Items/newestList.dart';
import 'package:foodapp/Screens/Order/Orders.dart';
import 'package:foodapp/Screens/Order/orderDetails.dart';
import 'package:foodapp/Screens/Profile/Profile.dart';
import 'package:foodapp/Screens/Sections/CategorySec.dart';
import 'package:foodapp/Screens/Sections/PopularSec.dart';
import 'package:foodapp/Screens/Sections/SearchCategory.dart';
import 'package:foodapp/Screens/Sections/newest.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/drawer.dart';
import 'package:foodapp/test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State {
  SharedPreferences? logindata;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  User ? loggedInUser;

  @override
  void initState() {
    super.initState();
    // Retrieve the currently logged-in user
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        loggedInUser = user;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Zwigzo',
          style: GoogleFonts.lato(fontWeight: FontWeight.w900, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon : Icon (Icons.search,color: Colors.black87),
            onPressed: (){
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return cart();
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
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.black87),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return wishlist();
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
          ),
        ],
      ),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // categorySearch(),
              SizedBox(
                height: 10
              ),
              Row(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 20, bottom: 0),
                      child: Text(
                        'Categories',
                        style: GoogleFonts.dmSans(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.1,
                  ),
                  GestureDetector(
                    child: Text('see all >',
                        style: GoogleFonts.dmSans(
                            fontSize: 15, color: Colors.green)),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return categoriesDetails();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(-1.0, 0.0);
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
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: categoriesSection()),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 20, bottom: 15, top: 10),
                      child: Text(
                        'Popular',
                        style: GoogleFonts.dmSans(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  PopularSec(),
                  SizedBox(height: 10,),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 20, bottom: 5, top: 10),
                      child: Text(
                        'Newest',
                        style: GoogleFonts.dmSans(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
              SizedBox(height: 10,),
              NewestSec()
            ]
          ),
        ),
      ),
    );
  }
}
