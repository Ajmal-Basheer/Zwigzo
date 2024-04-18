import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Screens/Buy/address.dart';
import 'package:foodapp/Screens/Items/Wishlist.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/loading.dart';
import '../../config/noItemFound.dart';

class BuyNow extends StatefulWidget {
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double itemvalue;

  BuyNow({required this.categoryDoc, required this.selectedItemID, required this.categoryName, required this.itemvalue});
  @override
  BuyNowState createState() => BuyNowState(
    categoryDoc: categoryDoc,
    selectedItemID: selectedItemID,
    categoryName: categoryName,
    itemvalue : itemvalue,
  );
}

class BuyNowState extends State<BuyNow> {
  late TextEditingController dropmoreController;
  int dropselectedValue = 1;
  double? totalAmount;
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double itemvalue;
  // Store the selected item ID
  BuyNowState({required this.categoryDoc, required this.selectedItemID, required this.categoryName, required this.itemvalue});

  @override
  void initState() {
    super.initState();
    dropmoreController = TextEditingController();
    totalAmount = itemvalue;
  }

  @override
  void dispose() {
    dropmoreController.dispose();
    super.dispose();
  }
  void _updateTotalAmount() {
    totalAmount = dropselectedValue * itemvalue; // Assuming the price is 120
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
                    _updateTotalAmount();
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
          'Buy Now',
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
              icon : Icon (Icons.favorite_border,color: Colors.black87),
              onPressed: (){
                Navigator.push(context,  PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return wishlist();
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    stream: _fetchItemDetailsStream(selectedItemID), // Fetch item details based on selected ID
    builder: (BuildContext context,
    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: loading(),
        );
      }

      if (!snapshot.hasData || !snapshot.data!.exists) {
        return noItemFound();
      }
      Map<String, dynamic> itemData = snapshot.data!.data()!;
      String ratingValue = itemData['rating'] ?? '0';
      double rating = double.tryParse(ratingValue) ?? 0;
      return Stack(
          children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                ),
                child: Column(
                    children: [
                      Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 3.6,
                                      child: Image.network(
                                          itemData['itemImagelink'])),
                                  PopupMenuButton<int>(
                                    color: Colors.white,
                                    onSelected: (value) {
                                      if (value == -1) {
                                        _showCustomValueDialog();
                                      } else {
                                        setState(() {
                                          dropselectedValue = value;
                                          _updateTotalAmount();
                                        });
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                    [
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
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(' Qty : ',
                                            style: GoogleFonts.poppins(),),
                                          Text(
                                            '$dropselectedValue',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold),
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
                                  itemData['itemName'],
                                  style: GoogleFonts.fjallaOne(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                RatingBar.builder(
                                  allowHalfRating: true,
                                  initialRating: rating,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Icon(
                                        Icons.star, color: primaryColor);
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
                                        style: TextStyle(
                                            color: primaryColor, fontSize: 20),
                                      ),
                                    ),
                                    Text(
                                      itemData['rupees'],
                                      style: GoogleFonts.notoSans(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                       '/ one',
                                        style: GoogleFonts.notoSans(
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1,),
                    ]
                )
            ),
          )
          ]
      );
    }
        )
        ),
      ),
      floatingActionButton: Container(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black26, // Customize the border color
                width: 1.0, // Customize the border width
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          '₹',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Text(
                        '$totalAmount',
                        style: GoogleFonts.notoSans(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return address(categoryDoc:categoryDoc, selectedItemID: selectedItemID,
                          categoryName: categoryName, totalprize: totalAmount,quantity:dropselectedValue);
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
                  child: Text('Place Order',
                      style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width / 2, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> _fetchItemDetailsStream(String itemID) {
    CollectionReference<Map<String, dynamic>> itemsCollection =
    FirebaseFirestore.instance.collection('foodCategory');
    return itemsCollection.doc(categoryDoc).collection(categoryName + 'Items').doc(itemID).snapshots();
  }
}