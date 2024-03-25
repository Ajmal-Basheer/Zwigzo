import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Items/ItemDetails.dart';
import 'package:foodapp/Screens/Items/itemsList.dart';
import 'package:google_fonts/google_fonts.dart';

class categoriesSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => categoriesSectionState();
}

class categoriesSectionState extends State {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('foodCategory').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: documents.map((QueryDocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width/4,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(1),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  blurStyle: BlurStyle.normal,
                                  color: Colors.black26,
                                  offset: Offset(1, 4),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: data['CatimageLink'] != ''
                                  ? Image.network(data['CatimageLink'],fit: BoxFit.cover,)
                                  : Container(
                                padding:  EdgeInsets.all(10),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child:
                                data['categoryName'] != null ? Text( data['categoryName'] ,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.dmSans(fontSize: 16),
                              ) : Container(
                                  width: 70,
                                  padding:  EdgeInsets.all(12),
                                  child: LinearProgressIndicator(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                            ),
                          )
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation,
                              secondaryAnimation) {
                            return ItemsList(categoryName:data['categoryName'],categoryDoc: document.id,);
                          },
                          transitionsBuilder: (context,
                              animation,
                              secondaryAnimation,
                              child) {
                            const curve = Curves.easeInOut;

                            var scaleTween = Tween(
                                begin: 0.0, end: 1.0)
                                .chain(
                                CurveTween(curve: curve));

                            var scaleAnimation =
                            animation.drive(scaleTween);

                            return ScaleTransition(
                                scale: scaleAnimation,
                                child: child);
                          },
                          transitionDuration:
                          Duration(milliseconds: 400),
                        ));
                  }
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
