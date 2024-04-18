// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:foodapp/Screens/Buy/newAddress.dart';
// import 'package:foodapp/Screens/Payment/Payment.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../config/colors.dart';
//
// class addresssOptions extends StatefulWidget {  @override
//   State<StatefulWidget> createState() => addresssOptionsState();
// }
// class addresssOptionsState extends State {  @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           ElevatedButton(
//             child: Text('Edit Address', style: GoogleFonts.heebo(
//                 color: Colors.black, fontSize: 12,fontWeight: FontWeight.bold)),
//             style: ButtonStyle(
//               backgroundColor:
//               MaterialStateProperty.all(Colors.grey[200]),
//               fixedSize:
//               MaterialStateProperty.all<Size>(Size(MediaQuery
//                   .of(context)
//                   .size
//                   .width - 40, 50)),
//               shape: MaterialStateProperty.all<
//                   RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             onPressed: (){
//
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
//             child: ElevatedButton(
//               child: Text('Add New Address', style: GoogleFonts.heebo(
//                   color: Colors.black, fontSize: 12,fontWeight: FontWeight.bold)),
//               style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all(Colors.grey[200]),
//                 fixedSize:
//                 MaterialStateProperty.all<Size>(Size(MediaQuery
//                     .of(context)
//                     .size
//                     .width - 40, 50)),
//                 shape: MaterialStateProperty.all<
//                     RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               onPressed: (){
//                 Navigator.push(context,  PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) {
//                     return newAddress();
//                   },
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) {
//                     const begin = Offset(1.0, 0.0);
//                     const end = Offset.zero;
//                     const curve = Curves.easeInOut;
//
//                     var tween = Tween(begin: begin, end: end)
//                         .chain(CurveTween(curve: curve));
//
//                     var offsetAnimation = animation.drive(tween);
//
//                     return SlideTransition(position: offsetAnimation, child: child);
//                   },
//                   transitionDuration: Duration(milliseconds: 400),
//                 ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: ElevatedButton(
//               child: Text('Deliver to this address', style: GoogleFonts.heebo(
//                   color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold)),
//               style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all(primaryColor),
//                 fixedSize:
//                 MaterialStateProperty.all<Size>(Size(MediaQuery
//                     .of(context)
//                     .size
//                     .width - 40, 50)),
//                 shape: MaterialStateProperty.all<
//                     RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               onPressed: (){
//                 Navigator.push(context,  PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) {
//                     return payment(
//
//                     );
//                   },
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) {
//                     const begin = Offset(1.0, 0.0);
//                     const end = Offset.zero;
//                     const curve = Curves.easeInOut;
//
//                     var tween = Tween(begin: begin, end: end)
//                         .chain(CurveTween(curve: curve));
//
//                     var offsetAnimation = animation.drive(tween);
//
//                     return SlideTransition(position: offsetAnimation, child: child);
//                   },
//                   transitionDuration: Duration(milliseconds: 400),
//                 ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
