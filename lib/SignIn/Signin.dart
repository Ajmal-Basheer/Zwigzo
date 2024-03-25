import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Home.dart';
import 'package:foodapp/SignUp/SignUp.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Signin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SigninState_();
}

class SigninState_ extends State {
  late final TextEditingController _usercontroller;
  late final TextEditingController _passcontroller;


  late SharedPreferences logindata;

  bool passVisible = true;

  bool usernameValidate_ = false;
  bool passwordValidate_ = false;

  bool validateField() {
    setState(() {
      usernameValidate_ = _usercontroller.text.isEmpty;
      passwordValidate_ = _passcontroller.text.isEmpty;

      if (_passcontroller.text.isEmpty) {
        passwordValidate_ = true;
      } else {
        passwordValidate_ = false;
      }
      if (_usercontroller.text.isEmpty) {
        usernameValidate_ = true;
      } else {
        usernameValidate_ = false;
      }
      if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(_usercontroller.text)) {
        usernameValidate_ = true;
      } else {
        usernameValidate_ = false;
      }
    });
    return !usernameValidate_ && !passwordValidate_;
  }

  void togglePasswordView() {
    setState(() {
      passVisible = !passVisible;
    });
  }

  @override
  void initState() {
    _passcontroller = TextEditingController();
    _usercontroller = TextEditingController();
    super.initState();
    logindatacheck();
  }

  void logindatacheck() async {
    logindata = await SharedPreferences.getInstance();
  }

  String _Useremail = '';
  int _success = 1;

  Future<void> _signin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _usercontroller.text, password: _passcontroller.text);
      if (userCredential != null) {
        setState(() {
          _success = 2;
          _Useremail = userCredential.user!.email!;
           logindata.setString('useremail', _Useremail);
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return HomeScreen();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0);
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
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _success = 3;
        usernameValidate_ = true;
        passwordValidate_ = true;
      });
    }
  }
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
              children: [
                Column(
          children: [
            Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
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
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Center(
                    child: Container(
                    height: MediaQuery.of(context).size.height / 1.9,
                    width: MediaQuery.of(context).size.width - 60,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                          boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          offset: Offset(1, 5))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                         child:Column(
                          children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Center(
                                    child: Text(
                                      'Sign In',
                                      style: GoogleFonts.roboto(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: ListView(children: [
                                      TextField(
                                        controller: _usercontroller,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.person,
                                            size: 20,
                                          ),
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(100),
                                            borderSide: BorderSide(color: Colors.black, width: 1),
                                          ),
                                          labelText: 'User Email',
                                          hintText: 'User Email',
                                          errorText: usernameValidate_ ? 'please enter valid username' : null,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      TextField(
                                        controller: _passcontroller,
                                        obscureText: passVisible,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(passVisible
                                                  ? Icons.visibility_off : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  togglePasswordView();
                                                });
                                              }),
                                          prefixIcon: Icon(
                                            Icons.security, size: 20,),
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                                   border: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(100),
                                                     borderSide: BorderSide(color: Colors.black, width: 1),
                                                   ),
                                          hintText: 'Password',
                                          labelText: 'Password',
                                          errorText: passwordValidate_ ? 'please enter valid password' : null,
                                        ),
                                      ),
                                    ])),
                             SizedBox(height: 20,),
                             ElevatedButton(
                               onPressed: () async {
                                 if (validateField()) {
                                   await _signin();
                                 } else {
                                   setState(() {
                                     usernameValidate_ = true;
                                     passwordValidate_ = true;
                                   });
                                 }
                                 },
                               child: Text('SIGN IN',
                                   style: GoogleFonts.heebo(color: Colors.white,
                                       fontSize: 16,
                                       fontWeight: FontWeight.bold)),
                               style: ButtonStyle(
                                 backgroundColor: MaterialStateProperty.all(primaryColor),
                                 fixedSize: MaterialStateProperty.all<Size>(
                                     Size(MediaQuery.of(context).size.width - 60, 50)),
                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(100.0),
                                   ),
                                 ),
                               ),
                             ),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: (){

                              },
                                child: Text('Forgot Password ?',style: GoogleFonts.openSans(color: Colors.blue,fontSize: 10),)),
                            GestureDetector(
                              onTap: (){
                                      Navigator.push(context, PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                      return SignUp();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const curve = Curves.easeInOut;

                                      var scaleTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

                                      var scaleAnimation = animation.drive(scaleTween);

                                      return ScaleTransition(scale: scaleAnimation, child: child);
                                      },
                                      transitionDuration: Duration(milliseconds: 200),
                                      ),
                                      );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Create an account ?',style: GoogleFonts.openSans(color: Colors.black,fontSize: 12),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('Sign Up',style: GoogleFonts.openSans(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 12)),
                                ],),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: ()async{
                                  UserCredential? userCredential = await _handleSignIn();
                                  if (userCredential != null ){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())) ;
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/1.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black45, // Set the border color here
                                        width: 1.0, // Set the border width here
                                      ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: ClipRRect(
                                          child: Image.network('https://seeklogo.com/images/G/google-logo-28FA7991AF-seeklogo.com.png'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Sign in with Google',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                           ]
                           ),
                         )
                    )
          ]
             )
              ]
          )
        )
    );
  }
}
