import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/Screens/Items/Wishlist.dart';
import 'package:foodapp/Screens/Items/itemsList.dart';
import 'package:foodapp/Screens/Sections/SearchCategory.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class categoriesDetails extends StatefulWidget {  @override
  State<StatefulWidget> createState() => categoriesDetailsState();
}
class categoriesDetailsState extends State {  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: scaffoldBackgroundColor,
    appBar: AppBar(
      backgroundColor: primaryColor,
      title: Text('Categories',style: GoogleFonts.jost(fontSize: 20),),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon : Icon (Icons.search,color: Colors.black87),
          onPressed: (){
            showSearch(context: context, delegate: MySearchDelegate());
          },
        ), IconButton(
          icon : Icon (Icons.shopping_cart,color: Colors.black87),
          onPressed: (){
            Navigator.push(context,  PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return cart();
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
    body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('foodCategory').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<QueryDocumentSnapshot<Object?>> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Object?> document = documents[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsList(categoryName: document['categoryName'], categoryDoc : document.id),
                                ),
                              );
                            },
                            leading: Container(
                              width: 50,
                              height: 50,
                              child: Image.network(document['CatimgPng']),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                            title: Text(
                              document['categoryName'],
                              style: GoogleFonts.heebo(fontSize: 19),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )),
  );
  }
}
