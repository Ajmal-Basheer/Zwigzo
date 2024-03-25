import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/Screens/Items/ItemDetails.dart';
import 'package:foodapp/Screens/Items/Wishlist.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/loading.dart';
import 'package:foodapp/config/noItemFound.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemsList extends StatefulWidget {
  final String categoryName;
  final String categoryDoc;

  ItemsList({required this.categoryName, required this.categoryDoc});

  @override
  State<StatefulWidget> createState() =>
      _ItemsListState(categoryName: categoryName, categoryDoc: categoryDoc);
}

class _ItemsListState extends State<ItemsList> {
  final String categoryName;
  final String categoryDoc;

  _ItemsListState({required this.categoryName, required this.categoryDoc});

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          categoryName,
          style: GoogleFonts.jost(fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => cart()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.black87),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => wishlist()),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _fetchItemsStream(categoryName),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: loading(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return noItemFound();
              }

              return Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot<Map<String, dynamic>> document =
                      snapshot.data!.docs[index];
                      Map<String, dynamic> data = document.data()!;
                      String itemName = data['itemName'] ?? '';
                      String itemImageLink = data['itemBg'] ?? '';
                      String ratingValue = data['rating'] ?? '0';
                      double rating = double.tryParse(ratingValue) ?? 0;
                      double rupees =
                          double.tryParse(data['rupees'].toString()) ?? 0.0;

                      return GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3.0,
                                      blurStyle: BlurStyle.normal,
                                      color: Colors.black12,
                                      offset: Offset(1, 4),
                                    ),
                                  ],
                                  color: Colors.black
                                ),
                                child: Stack(
                                  children:[
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 2.7,
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.network(itemImageLink,fit: BoxFit.cover,),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black38,
                                                Color(0x80000000),
                                                Color(0x22000000),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          )),
                                    ),
                                    Column(
                                    children: [
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 2.7,
                                        height: 90,
                                      ),
                                     Text(
                                          itemName,
                                          style: GoogleFonts.fjallaOne(fontSize: 15,color: Colors.white),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      RatingBar.builder(
                                        allowHalfRating: true,
                                        initialRating: rating,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return Icon(Icons.star, color: primaryColor);
                                        },
                                        itemSize: 15.0,
                                        unratedColor: Colors.grey[300],
                                        ignoreGestures: true,
                                        onRatingUpdate: (rating) {},
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '₹${rupees.toString()}',
                                            style: GoogleFonts.notoSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          // IconButton(
                                          //   icon: Icon(
                                          //     _isFavorite
                                          //         ? Icons.favorite
                                          //         : Icons.favorite_border,
                                          //     color: primaryColor,
                                          //   ),
                                          //   onPressed: () {
                                          //     setState(() {
                                          //       _isFavorite = !_isFavorite;
                                          //     });
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ]
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => itemDetails(categoryDoc:categoryDoc,
                                selectedItemID: document.id,categoryName : categoryName)),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _fetchItemsStream(
      String categoryName) {
    CollectionReference<Map<String, dynamic>> itemsCollection =
    FirebaseFirestore.instance.collection('foodCategory');
    return itemsCollection
        .doc(categoryDoc)
        .collection(categoryName + 'Items')
        .snapshots();
  }
}
