import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Admin/Partner/addPartner.dart';
import 'package:foodapp/Admin/Partner/partnersList.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class partnerManageHome extends StatefulWidget {  @override
State<StatefulWidget> createState() => partnerManageHomeState();
}
class partnerManageHomeState extends State {  @override
Widget build(BuildContext context) {
  return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Partner Manage',
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
                Tab(text: 'Add Partner'),
                Tab(text: 'Partners List'),
              ]),
        ),
        body: TabBarView(
            children:[
              addPartner(),
              partnersList(),
            ]
        ),
      )
  );
}
}
