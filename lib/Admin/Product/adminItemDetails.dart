import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Admin/Product/EditItemDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class adminItemDetails extends StatefulWidget {  @override
  State<StatefulWidget> createState()=>adminItemDetailsState();
}
class adminItemDetailsState extends State {  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: primaryColor,
       title: Text(
         'Item Details',
         style: GoogleFonts.jost(fontSize: 20),
       ),
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         onPressed: () {
           Navigator.of(context).pop();
         },
       ),
     ),
     body: SingleChildScrollView(
       child: SafeArea(
         child: Stack(
             children: [
               Column(
                   children: [
                     Container(
                         width: MediaQuery.of(context).size.width,
                         height: MediaQuery.of(context).size.height / 2.1,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                               bottomRight: Radius.circular(30),
                               bottomLeft: Radius.circular(30)),
                           color: primaryColor
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(30.0),
                           child: Image.network('https://static.vecteezy.com/system/resources/previews/022/911/684/non_2x/classic-chicken-burger-free-illustration-icon-free-png.png',
                           ),
                         )),
                     Container(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 15,top: 10),
                             child: Text('Chicken Burger',style: GoogleFonts.roboto(fontSize: 22,fontWeight: FontWeight.bold),),
                             ),
                           Padding(
                             padding: const EdgeInsets.only(left: 15,right: 20,top: 10,bottom: 10),
                             child: Text(
                               "Delight your taste buds with our succulent Chicken Burger, a culinary masterpiece that combines tender, juicy chicken with a symphony of complementary flavors. Nestled within a soft, freshly baked bun, our chicken patty is expertly seasoned and grilled to perfection, ensuring a mouthwatering experience with every bite.",
                               style: GoogleFonts.assistant(
                                   fontSize: 13, color: Color(0xc0000000)),
                               textAlign: TextAlign.justify,
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                             child: RatingBar.builder(
                               initialRating: 4,
                               itemCount: 5,
                               itemBuilder: (context, index) {
                                 return Icon(
                                     Icons.star,
                                     color: primaryColor);
                               },
                               itemSize: 22.0,
                               unratedColor: Colors.grey[300],
                               ignoreGestures: true,
                               onRatingUpdate: (rating) {
                               },
                             ),
                           ),
                           Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(left:15,right: 10,top: 5,),
                                 child: Text('₹',style: TextStyle(color: primaryColor,fontSize: 30),),
                               ),
                               Text('150',style: GoogleFonts.notoSans(fontSize: 30,fontWeight: FontWeight.bold,color: primaryColor),),
                             ],
                           ),
                           SizedBox(height: 10,),
                           Container(
                             alignment: Alignment.center,
                             child: ElevatedButton(
                               onPressed: () {
                                 Navigator.push(
                                   context,
                                   PageRouteBuilder(
                                     pageBuilder: (context, animation, secondaryAnimation) {
                                       return EditItemDetails();
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
                               child: Text('Edit Item Details',
                                   style: GoogleFonts.heebo(
                                       color: Colors.white,
                                       fontSize: 16,
                                       fontWeight: FontWeight.bold)),
                               style: ButtonStyle(
                                 backgroundColor: MaterialStateProperty.all(primaryColor),
                                 fixedSize: MaterialStateProperty.all<Size>(
                                     Size(MediaQuery.of(context).size.width / 1.1, 50)),
                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(50.0),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ]),
             ]),
       ),
     ),
   );
  }
}
