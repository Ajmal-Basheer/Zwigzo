import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/Admin/Product/AdminItemList.dart';
import 'package:foodapp/Admin/Product/UpdateCategory.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCategoriesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdminCategoriesListState();
}

class AdminCategoriesListState extends State {
  bool _isDeleting = false;
  final CollectionReference categories_ =
      FirebaseFirestore.instance.collection('foodCategory');

  Future<void> deleteCategory(String documentId, String imageUrl) async {
    try {
      setState(() {
        _isDeleting = true;
      });
      await categories_.doc(documentId).delete();
      if (imageUrl.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        print('Image deleted successfully');
      }
      print('Category deleted successfully!');
      Fluttertoast.showToast(msg: 'Category deleted successfully');
    } catch (e) {
      // Handle any errors
      print('Error deleting category: $e');
      Fluttertoast.showToast(msg: 'Category deleting failed');
    } finally {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Categories List',
                  style: GoogleFonts.dmSans(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3.0,
                        blurStyle: BlurStyle.normal,
                        color: Colors.black12,
                        offset: Offset(1, 4))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextField(
                        textAlign: TextAlign.start,
                        cursorColor: Colors.black54,
                        cursorWidth: 1.5,
                        decoration: InputDecoration(
                          hintText: 'Search Category',
                          hintStyle: GoogleFonts.roboto(
                              fontSize: 12, color: Colors.black45),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: StreamBuilder(
                      stream: categories_.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return loading();
                        }
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];
                              return Card(
                                elevation: 5,
                                color: Colors.white,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return AdminItemList();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(-1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));

                                          var offsetAnimation =
                                              animation.drive(tween);

                                          return SlideTransition(
                                              position: offsetAnimation,
                                              child: child);
                                        },
                                        transitionDuration:
                                            Duration(milliseconds: 400),
                                      ),
                                    );
                                  },
                                  leading: Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.network(
                                          document['CatimgPng'])),
                                  trailing: Container(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await deleteCategory(document.id, document['CatimageLink']);
                                          },
                                          icon: _isDeleting
                                              ? Container(
                                                  color: Colors.black26,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                )
                                              : Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            Navigator.push(context,  PageRouteBuilder(
                                              pageBuilder: (context, animation, secondaryAnimation) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return loading();
                                                }
                                                return updateCategory();
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
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    document['categoryName'],
                                    style: GoogleFonts.heebo(fontSize: 19),
                                  ),
                                ),
                              );
                            });
                      }),
                )),
          ]),
        ));
  }
}
