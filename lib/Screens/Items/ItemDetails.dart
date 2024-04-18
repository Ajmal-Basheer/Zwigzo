import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Screens/Items/BuyNow.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/loading.dart';
import '../../config/noItemFound.dart';

class itemDetails extends StatefulWidget {
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double itemvalue;

  itemDetails({required this.categoryDoc, required this.selectedItemID, required this.categoryName,required this.itemvalue});

  @override
  State<StatefulWidget> createState() => ItemDetailsState(
    categoryDoc: categoryDoc,
    selectedItemID: selectedItemID,
    categoryName: categoryName,
    itemvalue : itemvalue,
  );
}

class ItemDetailsState extends State<itemDetails> {
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double itemvalue;

  ItemDetailsState({required this.categoryDoc, required this.selectedItemID, required this.categoryName , required this.itemvalue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          gradient: LinearGradient(
                            colors: [Color(0xffffd755), primaryColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.network(itemData['itemImagelink'],
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: imageLoading(),
                            );
                          }
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    itemData['itemName'],
                                    style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: primaryColor,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
                              child: Text(
                                itemData['discription'],
                                style: GoogleFonts.assistant(
                                  fontSize: 13,
                                  color: Color(0xc0000000),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                              child: RatingBar.builder(
                                initialRating: rating,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Icon(Icons.star, color: primaryColor);
                                },
                                itemSize: 22.0,
                                unratedColor: Colors.grey[300],
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 10, top: 5),
                                  child: Text(
                                    '₹',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                Text(
                                  itemData['rupees'],
                                  style: GoogleFonts.notoSans(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return BuyNow(categoryDoc: categoryDoc,categoryName: categoryName, selectedItemID: selectedItemID,itemvalue : itemvalue);
                                      },
                                      transitionsBuilder:
                                          (context, animation, secondaryAnimation, child) {
                                        const curve = Curves.easeInOut;

                                        var scaleTween = Tween(begin: 0.0, end: 1.0)
                                            .chain(CurveTween(curve: curve));

                                        var scaleAnimation = animation.drive(scaleTween);

                                        return ScaleTransition(
                                            scale: scaleAnimation, child: child);
                                      },
                                      transitionDuration: Duration(milliseconds: 400),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Buy Now',
                                  style: GoogleFonts.heebo(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(primaryColor),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                    Size(MediaQuery.of(context).size.width / 1.1, 50),
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> _fetchItemDetailsStream(String itemID) {
    CollectionReference<Map<String, dynamic>> itemsCollection =
    FirebaseFirestore.instance.collection('foodCategory');
    return itemsCollection.doc(categoryDoc).collection(categoryName + 'Items').doc(itemID).snapshots();
  }
}
