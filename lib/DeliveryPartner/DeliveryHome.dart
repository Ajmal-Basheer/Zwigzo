import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/DeliveryPartner/OrderHistory.dart';
import 'package:foodapp/DeliveryPartner/PartnerInsights.dart';
import 'package:foodapp/DeliveryPartner/PartnerPayOut.dart';
import 'package:foodapp/DeliveryPartner/partnerOrderDetails.dart';
import 'package:foodapp/Screens/Order/orderDetails.dart';
import 'package:foodapp/Screens/Profile/Profile.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class deliveryHome extends StatefulWidget {  @override
  State<StatefulWidget> createState() => deliveryHomeState();
}
class deliveryHomeState extends State {
  String ? statusdropdownValue;
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
           child:DropdownButton<String>(
             hint: Text(
               'Status',
               style: TextStyle(color: Colors.black), // Set hint text color
             ),
             value: statusdropdownValue,
             onChanged: (String? newValue) {
               setState(() {
                 statusdropdownValue = newValue!;
               });
             },
             icon: Icon(Icons.arrow_drop_down), // Add an arrow icon
             iconSize: 24, // Set the size of the arrow icon
             elevation: 16, // Add elevation to the dropdown menu
             style: TextStyle(color: Colors.black), // Set text color of selected option
             underline: Container( // Customize the underline decoration
               height: 2,
               color: Colors.black26, // Set the color of the underline
             ),
             items: <String>['Online','Offline','On Delivery']
                 .map<DropdownMenuItem<String>>((String value) {
               return DropdownMenuItem<String>(
                 value: value,
                 child: Text(
                   value,
                   style: TextStyle(color: Colors.black), // Set text color of dropdown options
                 ),
               );
             }).toList(),
           ),
         ),
       ],
     ),
     drawer: Container(
       width: MediaQuery.of(context).size.width-130,
       color: Colors.white,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                     children: [
                       Padding(
                         padding: EdgeInsets.only(left: 20,top: 5),
                         child: Text('Arun Kumar', style: GoogleFonts.notoSansAdlam(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                       ),
                       Padding(
                         padding: EdgeInsets.only(left: 20,top: 5,bottom: 10),
                         child: Container(
                           padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                           decoration: BoxDecoration(
                             color: Colors.green,
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Text('Available',style: TextStyle(color: Colors.white,fontSize: 12),),
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
                 // Navigator.push(context,  PageRouteBuilder(
                 //   pageBuilder: (context, animation, secondaryAnimation) {
                 //     return userProfile();
                 //   },
                 //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
                 //     const curve = Curves.easeInOut;
                 //
                 //     var scaleTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
                 //
                 //     var scaleAnimation = animation.drive(scaleTween);
                 //
                 //     return ScaleTransition(scale: scaleAnimation, child: child);
                 //   },
                 //   transitionDuration: Duration(milliseconds: 400),
                 // ),
                 // );
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

           } ),
           Container(
             height: 1,
             width: MediaQuery.of(context).size.width,
             color: Colors.black12,),
         ],
       ),
     ),
     body: SafeArea(
         child: Column(
           children: [
             Container(
                 alignment: Alignment.topLeft,
                 padding: EdgeInsets.only(left: 20,top: 10),
                 child: Text('Orders',style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold),)),
            GestureDetector(
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
                    Container(
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
                                          child: Text('1 x',style:GoogleFonts.roboto(fontSize: 18),),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Zwigzo Biriyani',
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
                                            padding:  EdgeInsets.fromLTRB(10, 2, 10, 2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.red,width: 1,)
                                            ),
                                            child: Text('CASH',style: TextStyle(color: Colors.red),),
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
                                            child: Text('₹ 150',style: TextStyle(color: Colors.blue),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextButton(onPressed: (){},
                                            child: Text('Accept',style: TextStyle(color: Colors.green),)),
                                        TextButton(onPressed: (){},
                                            child: Text('Reject',style: TextStyle(color: Colors.red),))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container (
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
                                      'Ajmal Basheer',
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text('Valiyavila puthen veedu'),
                                    Text('690520'),
                                    Text('kollam'),
                                    Text('8606070030'),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
              ),
              onTap: (){
                Navigator.push(context,  PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return partnerOrderDetails();
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
            ),
           ],
         )
     ),
   );
  }
}
