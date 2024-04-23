import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/Screens/Items/ItemDetails.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class NewestSec extends StatefulWidget {

  @override
  State<StatefulWidget> createState() =>NewestSecState();
}

class NewestSecState extends State {


  bool _newestfav = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('foodCategory')
            .doc('WFggy3BwkneK7aa0qMsj')
            .collection('PizzaItems')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading();
          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: documents.map((QueryDocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<
                  String,
                  dynamic>;
              String ratingValue = data['rating'] ?? '0';
              double rating = double.tryParse(ratingValue) ?? 0;
              return  GestureDetector(
                child: Center(
                  child:Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 30,
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
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Colors.black,
                          //     Colors.black,
                          //     Colors.black,
                          //     Colors.black26,
                          //   ],
                          //   begin: Alignment.bottomCenter,
                          //   end: Alignment.topCenter,
                          // ),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: Opacity(
                                  opacity: .3,
                                  child: ClipRRect(
                                    child: Image.network('https://firebasestorage.googleapis.com/v0/b/zwigzo-food.appspot.com/o/assets%2FPizza%20BG.jpg?alt=media&token=2fb28c46-d447-4b60-b244-d60364e78a67',
                                      fit: BoxFit.cover,
                                    ),
                                                               borderRadius: BorderRadius.circular(10),
                                  ),
                                )),
                            Row(
                              children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                              child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 3.6,
                                  height: 180,
                                  child: Image.network(
                                    data['itemImagelink'],) ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                            data['itemName'],
                                      style: GoogleFonts.fjallaOne(
                                        fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 20,
                                    ),
                                    // IconButton(
                                    //   icon: Icon(
                                    //     _newestfav
                                    //         ? Icons.favorite
                                    //         : Icons.favorite_border,
                                    //     color: primaryColor,
                                    //   ),
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       _newestfav = !_newestfav;
                                    //     });
                                    //   },
                                    // ),
                                  ],
                                ),
                                Text(
                                  'Try Our Zwigzo special ${data['itemName']} \nFrom Zwigzo Restaurant',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                      color: Colors.white
                                  ),
                                ),
                                SizedBox(height: 5),
                                RatingBar.builder(
                                  initialRating: rating,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Icon(Icons.star, color: primaryColor);
                                  },
                                  itemSize: 20.0,
                                  unratedColor: Colors.grey[300],
                                  ignoreGestures: true,
                                  onRatingUpdate: (rating) {},
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
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    Text(
                                      data['rupees'],
                                      style: GoogleFonts.notoSans(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                          ]
                        ),
                    ),
                  ),
                ),
                onTap: () {
                  double rupees =
                      double.tryParse(data['rupees'].toString()) ?? 0.0;
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return itemDetails(categoryDoc: 'WFggy3BwkneK7aa0qMsj', selectedItemID: document.id, categoryName: 'Pizza', itemvalue: rupees);
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
                      ));
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
