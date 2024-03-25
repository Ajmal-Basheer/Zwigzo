import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Buy/address.dart';
import 'package:foodapp/Screens/Home.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/Screens/Order/orderDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrder extends StatefulWidget {   @override
  State<StatefulWidget> createState() => MyOrderState();
}
class MyOrderState extends State {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'My Order',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon : Icon (Icons.shopping_cart,color: Colors.black87),
              onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
              },
            ),
          ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                                      'https://img.freepik.com/premium-photo/bowl-food-with-piece-meat-vegetables-it_867452-673.jpg',height: 90,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            'Zwigzo Biriyani',
                            style: GoogleFonts.fjallaOne(
                              fontSize: 15,
                            ),
                          ),
                          Text(' Qty : 1',style:GoogleFonts.poppins(),),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                  child: Text('Delivering Soon',style: TextStyle(color: Colors.white,fontSize: 11),),
                                ),
                              TextButton(onPressed: (){},
                                  child: Text('Cancel',style: TextStyle(color: Colors.red),))
                            ],
                          ),
                        ],
                      ),
                    ),
                     IconButton(
                          onPressed: (){
                            Navigator.push(context,  PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return orderDetails();
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
                          icon : Icon (Icons.arrow_forward)
                      ),
                  ]),
                ),
          ],
        ),
      ),
      floatingActionButton:
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return HomeScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, -1.0);
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
                  child: Text('Continue Shopping',
                      style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width-20, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
