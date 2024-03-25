import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/Admin/Product/adminItemDetails.dart';
import 'package:foodapp/Screens/Order/orderDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EditItemDetails extends StatefulWidget
{  @override
  State<StatefulWidget> createState()=>EditItemDetailsState();
}
class EditItemDetailsState extends State {  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: scaffoldBackgroundColor,
     appBar: AppBar(
       backgroundColor: primaryColor,
       title: Text('Edit Item Details',style: GoogleFonts.jost(fontSize: 20),),
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         onPressed: () {
           Navigator.of(context).pop();
         },
       ),
     ),
     body: Padding(
       padding: const EdgeInsets.all(20.0),
      child:   SingleChildScrollView(
        child: Column(
             children: [
          Container(
          padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: Colors.white
         ),
              child :
               TextField(
                 style: TextStyle(color: Colors.black),
                 decoration: InputDecoration(
                   hintText: 'Chicken Burger',
                   hintStyle: TextStyle(color: Colors.black),
                   border: InputBorder.none,
                   prefixIcon: Icon(Icons.fastfood_sharp,color: Colors.black26,),
                 ),
               ),
          ),
               SizedBox(height: 10,),
               Container(
          padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: Colors.white
         ),
              child :
               TextField(
                 style: TextStyle(color: Colors.black),
                 decoration: InputDecoration(
                   hintText: '150',
                   hintStyle: TextStyle(color: Colors.black),
                   border: InputBorder.none,
                   prefixIcon: Icon(Icons.currency_rupee,color: Colors.black26,),
                 ),
               ),
          ),
               SizedBox(height: 10,),
               Container(
          padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: Colors.white
         ),
              child :
               TextField(
                 style: TextStyle(color: Colors.black),
                 decoration: InputDecoration(
                   hintText: '4.5',
                   hintStyle: TextStyle(color: Colors.black),
                   border: InputBorder.none,
                   prefixIcon: Icon(Icons.star,color: Colors.black26,),
                 ),
                 textCapitalization: TextCapitalization.words,
               ),
          ),
               SizedBox(height: 10,),
               Container(
          padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: Colors.white
         ),
              child :
               TextField(
                 style: TextStyle(color: Colors.black),
                 keyboardType: TextInputType.multiline, // Enable multi-line input
                 maxLines: null,
                 decoration: InputDecoration(
                   hintText: 'Discription',
                   hintStyle: TextStyle(color: Colors.black),
                   border: InputBorder.none,
                   prefixIcon: Icon(Icons.note_add,color: Colors.black26,),
                 ),
                 textCapitalization: TextCapitalization.words,
               ),
          ),
               SizedBox(height: 10,),
               Container(
                 padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.white
                 ),
                 child :
                 TextField(
                   style: TextStyle(color: Colors.black),
                   keyboardType: TextInputType.multiline, // Enable multi-line input
                   maxLines: null,
                   decoration: InputDecoration(
                     hintText: 'link',
                     hintStyle: TextStyle(color: Colors.black),
                     border: InputBorder.none,
                     prefixIcon: Icon(Icons.image,color: Colors.black26,),
                   ),
                   textCapitalization: TextCapitalization.words,
                 ),
               ),
               SizedBox(height: 10,),
               ElevatedButton(
                 child: Text('Cancel', style: GoogleFonts.heebo(
                     color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold)),
                 style: ButtonStyle(
                   backgroundColor:
                   MaterialStateProperty.all(Colors.grey),
                   fixedSize:
                   MaterialStateProperty.all<Size>(Size(MediaQuery
                       .of(context)
                       .size
                       .width - 20, 50)),
                   shape: MaterialStateProperty.all<
                       RoundedRectangleBorder>(
                     RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                 ),
                 onPressed: (){
                   Navigator.pop(context);
                 },
               ),
               SizedBox(height: 10,),
             ElevatedButton(
                   child: Text('Update', style: GoogleFonts.heebo(
                       color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold)),
                   style: ButtonStyle(
                     backgroundColor:
                     MaterialStateProperty.all(primaryColor),
                     fixedSize:
                     MaterialStateProperty.all<Size>(Size(MediaQuery
                         .of(context)
                         .size
                         .width - 20, 50)),
                     shape: MaterialStateProperty.all<
                         RoundedRectangleBorder>(
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
                       return adminItemDetails();
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
             ],
           ),
      ),
       ),
  );
  }
}
