import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class categorySearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ButtonState();
}

class ButtonState extends State<categorySearch> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child: Padding(
          padding: const EdgeInsets.only(top: 20),
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
                        enabled: false,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.black54,
                        cursorWidth: 1.5,
                        decoration: InputDecoration(
                          hintText: 'What would you like to have ?',
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
      onTap: (){
      showSearch(context: context, delegate: MySearchDelegate());
    },
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final CollectionReference firestore =
  FirebaseFirestore.instance.collection('foodCategory');

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear)),
      ];

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(
          onPressed: () => close(context, null),
          icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder(
          stream: firestore.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final List<DocumentSnapshot> categoriesList = snapshot.data?.docs ??
                [];
            final List<DocumentSnapshot> filteredCategories = _filterCategories(
                categoriesList);

            return ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                final itemName = category['categoryName'];
                final imageLink = category['CatimageLink'];

                return GestureDetector(
                  onTap: () {
                    query = itemName;
                    showResults(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            imageLink,
                          ),
                        ),
                        title: Text(
                          itemName,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
      ),
    );
  }

  List<DocumentSnapshot> _filterCategories(
      List<DocumentSnapshot> categoriesList) {
    if (query.isEmpty) {
      return categoriesList;
    }

    return categoriesList.where((category) {
      final categoryName = category['categoryName'].toString().toLowerCase();
      return categoryName.contains(query.toLowerCase());
    }).toList();
  }
}
