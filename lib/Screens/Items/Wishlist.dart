import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Screens/Buy/address.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class wishlist extends StatefulWidget {  @override
  State<StatefulWidget> createState() => wishlistState();
}
class wishlistState extends State {
  late TextEditingController dropmoreController;
  int dropselectedValue = 1;

  @override
  void initState() {
    super.initState();
    dropmoreController = TextEditingController();
  }

  @override
  void dispose() {
    dropmoreController.dispose();
    super.dispose();
  }

  void _showCustomValueDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Enter Quantity',style: TextStyle(fontSize: 20),),
          content: TextField(
            controller: dropmoreController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                dropmoreController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color: Colors.black),),
            ),
            TextButton(
              onPressed: () {
                if (dropmoreController.text.isNotEmpty) {
                  setState(() {
                    dropselectedValue = int.parse(dropmoreController.text);
                  });
                  dropmoreController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Ok',style: TextStyle(color: Colors.black),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: scaffoldBackgroundColor,
     appBar: AppBar(
       backgroundColor: primaryColor,
       title: Text(
         'My Wishlist',
         style: GoogleFonts.jost(fontSize: 20),
       ),
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         onPressed: () {
           Navigator.of(context).pop();
         },
       ),
       actions: [
         Padding(
           padding: EdgeInsets.only(right: 10),
           child: IconButton(
             icon : Icon (Icons.shopping_cart,color: Colors.black87),
             onPressed: (){
               Navigator.push(context,  PageRouteBuilder(
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

                   return SlideTransition(position: offsetAnimation, child: child);
                 },
                 transitionDuration: Duration(milliseconds: 400),
               ),
               );
             },
           ),
         ),
       ],
     ),
     body: Padding(
       padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
       child: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height/3.9,
         decoration: BoxDecoration(
           boxShadow: [
             BoxShadow(
               blurRadius: 3.0,
               blurStyle: BlurStyle.normal,
               color: Colors.black12,
               offset: Offset(1, 4),
             ),
           ],
           color: Colors.white,
           borderRadius: BorderRadius.circular(20)
         ),
         child: Column(
           children: [
             Row(
                 children: [
                   Padding(
                     padding: EdgeInsets.fromLTRB(10, 10, 15, 0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                             alignment: Alignment.center,
                             width: MediaQuery.of(context).size.width / 3.7,
                             child: Image.network(
                                 'https://img.freepik.com/premium-photo/bowl-food-with-piece-meat-vegetables-it_867452-673.jpg')),
                         PopupMenuButton<int>(
                           color: Colors.white,
                           onSelected: (value) {
                             if (value == -1) {
                               _showCustomValueDialog();
                             } else {
                               setState(() {
                                 dropselectedValue = value;
                               });
                             }
                           },
                           itemBuilder: (BuildContext context) => [
                             for (int i = 1; i <= 5; i++)
                               PopupMenuItem<int>(
                                 value: i,
                                 child: Text('$i'),
                               ),
                             PopupMenuItem<int>(
                               value: -1,
                               child: Text('more'),
                             ),
                           ],
                           child: Container(
                             padding: EdgeInsets.all(3),
                             decoration: BoxDecoration(
                               border: Border.all(color: Colors.grey.shade300),
                             ),
                             child: Row(
                               children: [
                                 Text(' Qty : ',style:GoogleFonts.poppins(),),
                                 Text(
                                   '$dropselectedValue',
                                   style:GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                 ),
                                 Icon(Icons.arrow_drop_down)
                               ],
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'Zwigzo Biriyani',
                         style: GoogleFonts.fjallaOne(
                           fontSize: 20,
                         ),
                       ),
                       SizedBox(height: 5),
                       RatingBar.builder(
                         initialRating: 4,
                         itemCount: 5,
                         itemBuilder: (context, index) {
                           return Icon(Icons.star, color: primaryColor);
                         },
                         itemSize: 20.0,
                         unratedColor: Colors.grey[300],
                         ignoreGestures: true,
                         onRatingUpdate: (rating) {},
                       ),
                       SizedBox(height: 5,),
                       Text(
                         'Free Delivery',
                         style: GoogleFonts.roboto(
                           fontSize: 12,
                           color: CupertinoColors.systemGreen,
                         ),
                       ),
                       SizedBox(
                         height: 5,
                       ),
                       Row(
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(right: 5),
                             child: Text(
                               '₹',
                               style: TextStyle(color: primaryColor, fontSize: 20),
                             ),
                           ),
                           Text(
                             '120',
                             style: GoogleFonts.notoSans(
                                 fontSize: 25,
                                 fontWeight: FontWeight.bold,
                                 color: primaryColor),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ]
             ),
             SizedBox(height: 10,),
             Divider(height: 1,),
             Container(
               width: MediaQuery.of(context).size.width,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   TextButton(
                       onPressed: (){

                       },
                       child: Row(
                         children: [
                           Icon(Icons.delete,color: Colors.black54,size: 15,),
                           Text("Remove",style: TextStyle(color: Colors.black54),),
                         ],
                       )),
                   Container(
                     width: 1,
                     height: 30,
                     color: Colors.black26,
                   ),
                   TextButton(
                       onPressed: (){
                         Navigator.push(context,  PageRouteBuilder(
                           pageBuilder: (context, animation, secondaryAnimation) {
                             return address();
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
                       child: Row(
                         children: [
                           Icon(Icons.flash_on,color: Colors.black54,size: 15,),
                           Text("Buy this Now",style: TextStyle(color: Colors.black54),),
                         ],
                       )),
                   Container(
                     width: 1,
                     height: 30,
                     color: Colors.black26,
                   ),
                   TextButton(
                       onPressed: (){

                       },
                       child: Row(
                         children: [
                           Icon(Icons.shopping_cart,color: Colors.black54,size: 15,),
                           Text("Add to Cart",style: TextStyle(color: Colors.black54),),
                         ],
                       )),
                 ],
               ),
             ),
           ],
         ),
       ),
     ),
   );
  }
}
