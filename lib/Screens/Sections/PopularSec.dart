import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Screens/Items/ItemDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularSec extends StatefulWidget {

  @override
  State<StatefulWidget> createState() =>
      PopularSecState();
}

class PopularSecState extends State {

  bool _loading = true;
  bool _popularfav = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('foodCategory')
            .doc('FILN0PFsHzgRN7XulAbX')
            .collection('BurgerItems')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: documents.map((QueryDocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String ratingValue = data['rating'] ?? '0';
              double rating = double.tryParse(ratingValue) ?? 0;
              return GestureDetector(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(style: BorderStyle.solid,color: Colors.black),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3.0,
                            blurStyle: BlurStyle.normal,
                            color: Colors.black26,
                            offset: Offset(1, 4),
                          ),
                        ],
                        color: Colors.black,
                      ),
                      child: Stack(children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Image.network(data['itemBg'],
                                    fit: BoxFit.cover, loadingBuilder:
                                        (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                  errorBuilder:  (context, error, stackTrace) => Center(
                                    child: Icon(Icons.error),
                                  ),
                                  gaplessPlayback: true,
                                    ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                data['itemName'],
                                style: GoogleFonts.inter(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                            //   child: RatingBar.builder(
                            //     initialRating: rating,
                            //     allowHalfRating: true,
                            //     itemCount: 5,
                            //     itemBuilder: (context, index) {
                            //       return Icon(Icons.star, color: primaryColor);
                            //     },
                            //     itemSize: 22.0,
                            //     unratedColor: Colors.grey[300],
                            //     ignoreGestures: true,
                            //     onRatingUpdate: (rating) {},
                            //   ),
                            // ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 10),
                                  child: Text(
                                    '₹',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 10),
                                  child: Text(
                                    data['rupees'],
                                    style: GoogleFonts.notoSans(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width /
                                //       20,
                                // ),
                                // IconButton(
                                //   icon: Icon(
                                //     _popularfav
                                //         ? Icons.favorite
                                //         : Icons.favorite_border,
                                //     color: Colors.red.shade300,
                                //   ),
                                //   onPressed: () {
                                //     setState(() {
                                //       _popularfav = !_popularfav;
                                //     });
                                //   },
                                // ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ]),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageRouteBuilder(
                  //     pageBuilder: (context, animation, secondaryAnimation) {
                  //       return itemDetails(
                  //         categoryDoc: document.id, selectedItemID: '', categoryName: '', // Fix selected item ID
                  //       );
                  //     },
                  //     transitionsBuilder:
                  //         (context, animation, secondaryAnimation, child) {
                  //       const curve = Curves.easeInOut;
                  //
                  //       var scaleTween = Tween(begin: 0.0, end: 1.0)
                  //           .chain(CurveTween(curve: curve));
                  //
                  //       var scaleAnimation = animation.drive(scaleTween);
                  //
                  //       return ScaleTransition(
                  //           scale: scaleAnimation, child: child);
                  //     },
                  //     transitionDuration: Duration(milliseconds: 400),
                  //   ),
                  // );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
