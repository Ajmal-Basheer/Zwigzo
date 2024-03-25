import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Admin/Order/AdminOrdersHistory.dart';
import 'package:foodapp/Admin/Order/newOrder.dart';
import 'package:foodapp/Admin/Product/AddItem.dart';
import 'package:foodapp/Admin/Product/CategoriesList.dart';
import 'package:foodapp/Admin/Product/EditItemDetails.dart';
import 'package:foodapp/Admin/Product/addCategory.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageProduct extends StatefulWidget {  @override
State<StatefulWidget> createState() => ManageProductState();
}
class ManageProductState extends State {  @override
Widget build(BuildContext context) {
  return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Product Manage',
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
                Tab(text: 'Category'),
                Tab(text: 'Category List'),
                Tab(text: 'Add Item'),
              ]),
        ),
        body: TabBarView(
            children:[
              addCategory(),
              AdminCategoriesList(),
              addItem(),
            ]
        ),
      )
  );
}
}
