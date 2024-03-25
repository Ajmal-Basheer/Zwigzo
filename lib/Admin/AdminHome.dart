import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/Admin/Order/OrderManageHome.dart';
import 'package:foodapp/Admin/Partner/PartnerManage.dart';
import 'package:foodapp/Admin/Product/ManageProduct.dart';
import 'package:foodapp/Admin/USER/userList.dart';
import 'package:foodapp/DeliveryPartner/OrderHistory.dart';
import 'package:foodapp/DeliveryPartner/PartnerInsights.dart';
import 'package:foodapp/DeliveryPartner/PartnerPayOut.dart';
import 'package:foodapp/DeliveryPartner/partnerOrderDetails.dart';
import 'package:foodapp/Screens/Profile/Profile.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class adminHome extends StatefulWidget {  @override
State<StatefulWidget> createState() => adminHomeState();
}
class adminHomeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text('Zwigzo',style: GoogleFonts.lato(fontWeight: FontWeight.w900,fontSize: 25),),
            Text('DASHBOARD',style: GoogleFonts.abel(fontWeight: FontWeight.w900,fontSize: 10,letterSpacing: 1),),
          ],
        ),
      ),
      drawer: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width-130,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: primaryColor,
                    padding: EdgeInsets.all(40),
                    child: Image.asset('assets/Zwigzo_logo.png')),
                Divider(height: 1,),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: GestureDetector(
                    child: ListTile(title: Text('User Manage',style: TextStyle(fontWeight: FontWeight.w600),),
                      leading: Icon(Icons.person,color: Colors.black54,),),
                    onTap: (){
                      Navigator.push(context,  PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return UsersList();
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
                    child: ListTile( title: Text('Order Manage',style: TextStyle(fontWeight: FontWeight.w600),),
                      leading: Icon(Icons.card_travel,color: Colors.black54,),
                    ), onTap: (){
                  Navigator.push(context,  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return OrderManageHome();
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
                    child: ListTile( title: Text('Partner Manage',style: TextStyle(fontWeight: FontWeight.w600),),
                      leading: Icon(Icons.delivery_dining,color: Colors.black54,),
                    ), onTap: (){
                  Navigator.push(context,  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return partnerManageHome();
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
                    child: ListTile( title: Text('Food Manage',style: TextStyle(fontWeight: FontWeight.w600),),
                      leading: Icon(Icons.fastfood,color: Colors.black54,),
                    ), onTap: (){
                  Navigator.push(context,  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return ManageProduct();
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
                    child: ListTile( title: Text('Logout',style: TextStyle(fontWeight: FontWeight.w600),),
                      leading: Icon(Icons.exit_to_app,color: Colors.black54,),
                    ), onTap: (){
                    
                } ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text('Order Overview',style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold),)),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      InsightCard(
                        title: 'Total Orders',
                        value: '325',
                        icon: Icons.delivery_dining,
                        color: Colors.blue,
                      ),
                      InsightCard(
                        title: 'Placed Orders',
                        value: '22',
                        icon: Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      InsightCard(
                        title: 'Active Orders',
                        value: '3',
                        icon: Icons.timelapse,
                        color: Colors.black45,
                      ),
                      InsightCard(
                        title: 'Cancelled Orders',
                        value: '3',
                        icon: Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Manage',style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold),)),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         GestureDetector(
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Container(
                               padding: EdgeInsets.all(15),
                               width: MediaQuery.of(context).size.width/2.5,
                               height: 100,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only( topLeft: Radius.circular(20)),
                                 color: Colors.white,
                                   boxShadow: [
                                     BoxShadow(
                                         blurRadius: .5,
                                         offset: Offset(4, 4),
                                         color: Colors.black12
                                     ),
                                   ]
                               ),
                               child: Column(
                                 children: [
                                    Icon(Icons.shopping_cart_checkout_outlined,size: 35,color:  Colors.blue,),
                                    Text('Order Manage',style: GoogleFonts.robotoCondensed(fontSize: 18,color:  Colors.black),),
                                 ],
                               ),
                             ),
                           ),
                             onTap: (){
                               Navigator.push(context,  PageRouteBuilder(
                                 pageBuilder: (context, animation, secondaryAnimation) {
                                   return  OrderManageHome();
                                 },
                                 transitionsBuilder:
                                     (context, animation, secondaryAnimation, child) {
                                   const begin = Offset(-1.0, 0.0);
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
                         ),
                         GestureDetector(
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Container(
                               padding: EdgeInsets.all(15),
                               width: MediaQuery.of(context).size.width/2.5,
                               height: 100,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only( topRight: Radius.circular(20)),
                                 color: Colors.white,
                                   boxShadow: [
                                     BoxShadow(
                                         blurRadius: .5,
                                         offset: Offset(-4, 4),
                                         color: Colors.black12
                                     ),
                                   ]
                               ),
                               child: Column(
                                 children: [
                                   Icon(Icons.fastfood_outlined,size: 35,color:  Colors.blue,),
                                   Text('Food Manage',style: GoogleFonts.robotoCondensed(fontSize: 18,color:  Colors.black),),
                                 ],
                               ),
                             ),
                           ),
                           onTap: (){
                             Navigator.push(context,  PageRouteBuilder(
                               pageBuilder: (context, animation, secondaryAnimation) {
                                 return ManageProduct();
                               },
                               transitionsBuilder:
                                   (context, animation, secondaryAnimation, child) {
                                 const begin = Offset(-1.0, 0.0);
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
                         ),
                       ],
                     ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width/2.5,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only( bottomLeft: Radius.circular(20)),
                                  color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: .5,
                                          offset: Offset(4, -4),
                                          color: Colors.black12
                                      ),
                                    ]
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Icon(Icons.delivery_dining,size: 35,color:  Colors.blue,),
                                      Text('Partner Manage',style: GoogleFonts.robotoCondensed(fontSize: 18,color:  Colors.black),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context,  PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return  partnerManageHome();
                                },
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(-1.0, 0.0);
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
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width/2.5,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only( bottomRight: Radius.circular(20)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: .5,
                                      offset: Offset(-4, -4),
                                      color: Colors.black12
                                    ),
                                  ]
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.person,size: 35,color: Colors.blue,),
                                    Text('User Manage',style: GoogleFonts.robotoCondensed(fontSize: 18,color: Colors.black),),
                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context,  PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return  UsersList();
                                },
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(-1.0, 0.0);
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
                          ),
                      ]),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}