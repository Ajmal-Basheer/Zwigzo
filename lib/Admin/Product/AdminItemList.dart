import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adminItemDetails.dart';

class AdminItemList extends StatefulWidget {  @override
  State<StatefulWidget> createState() =>AdminItemListState();
}
class AdminItemListState extends State {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: scaffoldBackgroundColor,
       appBar: AppBar(
         backgroundColor: primaryColor,
         title: Text(
           'Item List',
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
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 20,bottom: 20),
                 child: Container(
                   width: MediaQuery.of(context).size.width-40,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(30),
                     boxShadow: [
                       BoxShadow(
                           blurRadius: 3.0,
                           blurStyle: BlurStyle.normal,
                           color: Colors.black12,
                           offset: Offset(1, 4)
                       )],
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.search,color: Colors.black45,),
                       SizedBox(width: 10,),
                       Container(
                         width:  MediaQuery.of(context).size.width/1.7,
                         child: TextField(
                           textAlign: TextAlign.start,
                           cursorColor: Colors.black54,
                           cursorWidth: 1.5,
                           decoration: InputDecoration(
                             hintText: 'Search Item',
                             hintStyle: GoogleFonts.roboto(fontSize: 12,color: Colors.black45),
                             border: InputBorder.none,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               Container(
                 child: Padding(
                   padding: const EdgeInsets.only(right: 15,left: 15),
                   child: Card(
                     elevation: 5,
                     color: Colors.white,
                     child: ListTile(
                       onTap: (){
                         Navigator.push(context,  PageRouteBuilder(
                           pageBuilder: (context, animation, secondaryAnimation) {
                             return adminItemDetails();
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
                       leading: Container(
                           width: 50,
                           height: 50,
                           child: Image.network('https://static.vecteezy.com/system/resources/previews/026/158/966/original/a-slice-of-hot-pizza-with-stretchy-cheese-slice-of-fresh-italian-classic-original-pepperoni-pizza-generative-ai-png.png')),
                       trailing: IconButton(
                         onPressed: (){},
                         icon : Icon (Icons.delete,color: Colors.red,),),
                       title: Text("Riya's Special Chicken Pizza",style: GoogleFonts.heebo(fontSize: 15),),
                     ),
                   ),
                 ),
               ),
             ],
           )
       ),
     ),
   );
  }
}
