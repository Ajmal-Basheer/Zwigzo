import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Items/Cart.dart';
import 'package:foodapp/Screens/Items/ItemDetails.dart';
import 'package:foodapp/Screens/Items/Wishlist.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class popularItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => popularItemsState();
}

class popularItemsState extends State {
  bool _popularfav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Popular',
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
                  PageRouteBuilder(
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

                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                    transitionDuration: Duration(milliseconds: 400),
                  ),
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
                    PageRouteBuilder(
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

                        return SlideTransition(
                            position: offsetAnimation, child: child);
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
            child: Column(children: [
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
                        hintText: 'Search',
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    // Enable scrolling for GridView
                    itemCount: 8,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      childAspectRatio: .8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.7,
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
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        'https://static.vecteezy.com/system/resources/previews/022/911/684/non_2x/classic-chicken-burger-free-illustration-icon-free-png.png')),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Chicken Burger',
                                    style: GoogleFonts.fjallaOne(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Restaurants Name',
                                    style: GoogleFonts.abel(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 5),
                                    child: Text(
                                      '₹',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    '100',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _popularfav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _popularfav = !_popularfav;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return itemDetails(
                                    categoryDoc: '',
                                    selectedItemID: '',
                                    categoryName: '',
                                    itemvalue: 0,
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const curve = Curves.easeInOut;

                                  var scaleTween = Tween(begin: 0.0, end: 1.0)
                                      .chain(CurveTween(curve: curve));

                                  var scaleAnimation =
                                      animation.drive(scaleTween);

                                  return ScaleTransition(
                                      scale: scaleAnimation, child: child);
                                },
                                transitionDuration: Duration(milliseconds: 400),
                              ));
                        },
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ])));
  }
}
