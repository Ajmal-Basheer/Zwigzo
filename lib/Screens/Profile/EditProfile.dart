import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Profile/Profile.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class editProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => editProfileState();
}

class editProfileState extends State {
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                    children: [
                Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  gradient: LinearGradient(
                    colors: [Color(0xffffd755), primaryColor],
                    // Set your desired gradient colors
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
          ),
                ]
              ),
                Column(
                  children: [
                    Center(
                      heightFactor: 1.5,
                      child: Container(height: MediaQuery.of(context).size.height /1.5,
                          width: MediaQuery.of(context).size.width - 60,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black26,
                                    offset: Offset(1, 5)
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: StreamBuilder(
                                  stream:  users.doc(_user!.uid).snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      if (!snapshot.hasData || snapshot.data == null) {
                                        print('No user data found.');
                                      }
                                      final userData = snapshot.data!.data() as Map<String, dynamic>;
                                      return ListView(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: userData['username'],
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            helperText: 'Full Name',
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: userData['email'],
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            helperText: 'Email Id',
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: userData['phoneNumber'],
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            helperText: 'Mobile Number',
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: userData['pinNumber'],
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            helperText: 'Pin Number',
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: userData['address'],
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            helperText: 'Primary Address',
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: userData['district'],
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            helperText: 'District',
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) {
                                          return userProfile();
                                        },
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          const begin = Offset(-1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;

                                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                          var offsetAnimation = animation.drive(tween);

                                          return SlideTransition(position: offsetAnimation, child: child);
                                        },
                                        transitionDuration: Duration(milliseconds: 400),
                                      ),
                                    );
                                  });
                                },
                                child: Text('SUBMIT', style: GoogleFonts.heebo(
                                    color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold)),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                                  fixedSize:
                                  MaterialStateProperty.all<Size>(Size(MediaQuery
                                      .of(context)
                                      .size
                                      .width - 60, 50)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close)),
                ),
                  ],
                ),
            ),
        ),
    );
  }
}
