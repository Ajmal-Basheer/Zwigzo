import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Admin/AdminHome.dart';
import 'package:foodapp/Admin/Order/AdminOrdersHistory.dart';
import 'package:foodapp/Admin/Order/newOrder.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderManageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderManageHomeState();
}
class OrderManageHomeState extends State {
  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
      length: 2,
      child: Scaffold(
    backgroundColor: scaffoldBackgroundColor,
    appBar: AppBar(
      backgroundColor: primaryColor,
        actions: [
        TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>adminHome()));
        },
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
      ),
      ],
      title: Text(
        'Order Manage',
        style: GoogleFonts.jost(fontSize: 20),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),

      bottom: TabBar(
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          indicatorColor: Colors.white,
          tabAlignment: TabAlignment.center,
          labelStyle: GoogleFonts.aBeeZee(fontSize: 15),
          tabs: [
            Tab(text: 'New Orders'),
            Tab(text: 'Order History'),
          ]),
    ),
    body: TabBarView(
        children:[
          newOrder(),
          AdminOrderHis(),
        ]
    ),
      )
  );
  }
}
