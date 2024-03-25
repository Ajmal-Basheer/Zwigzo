import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/config/Timeline.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class orderDetails extends StatefulWidget {  @override
  State<StatefulWidget> createState() =>orderDetailsState();
}
class orderDetailsState extends State {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Order Details',
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                ),
                child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width/3.6,
                            child: Image.network('https://img.freepik.com/premium-photo/bowl-food-with-piece-meat-vegetables-it_867452-673.jpg')),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Text('Zwigzo Biriyani',
                                style: GoogleFonts.fjallaOne(fontSize: 18,),
                              ),
                          Text('Qty : 1',style:GoogleFonts.poppins(),),
        
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text('₹',style: TextStyle(color: primaryColor,fontSize: 20),),
                              ),
                              Text('150',style: GoogleFonts.notoSans(fontSize: 22,fontWeight: FontWeight.bold,color: primaryColor),),
                            ],
                          ),
                        ],
                      ),
                    ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    ),
        
                child: Column(
                  children: [
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('items : ',),
                            Text('₹ 150',),
                          ],
                        )),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('delivery : ',),
                            Text('₹ 0',),
                          ],
                        )),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('total : ',),
                            Text('₹ 150',),
                          ],
                        )),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order Total : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            Text('₹ 150',),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment : ',),
                    Text('Cash On Delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                   ),
        
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    timeLine(isFirst: true,
                        isLast: false,
                        isPast: true,
                      eventCard:Text('Order Placed',style: GoogleFonts.abel(
                          fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),),),
                    timeLine(isFirst: false,
                        isLast: false,
                        isPast: false,
                      eventCard: Text('Out For Delivery',style: GoogleFonts.abel(
                          fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),),
                    ),
                    timeLine(
                      isFirst: false,
                      isLast: true,
                      isPast: false,
                      eventCard: Text("Delivered",style: GoogleFonts.abel(
                          fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
