import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/Admin/Partner/PartnerManage.dart';
import 'package:foodapp/SignIn/Signin.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class addPartner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => addPartnerState();
}

class addPartnerState extends State {

  PlatformFile ? pickedfile;

  late final TextEditingController _nameController;
  late final TextEditingController _PasswordController;
  late final TextEditingController _ConfirmPasswordController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _pinController;
  late final TextEditingController _districtController;

  bool _nameValidate = false;
  bool _passValidate = false;
  bool _confirmValidate = false;
  bool _emailValidate = false;
  bool _phoneValidate = false;
  bool _pinValidate = false;
  bool _districtValidate = false;
  bool _addressValidate = false;
  bool _errorpasscontroller = false;
  bool _erroremail = false;
  bool _errorphone = false;
  bool _passwordcount = false;
  bool _isLoading = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _ConfirmPasswordController = TextEditingController();
    _addressController = TextEditingController();
    _PasswordController = TextEditingController();
    _pinController = TextEditingController();
    _districtController = TextEditingController();
    super.initState();
  }
  bool validateFields() {
    setState(() {
      _nameValidate = _nameController.text.isEmpty;
      _passValidate = _PasswordController.text.isEmpty;
      _confirmValidate = _ConfirmPasswordController.text.isEmpty;
      _emailValidate = _emailController.text.isEmpty;
      _phoneValidate = _phoneController.text.isEmpty;
      _addressValidate = _addressController.text.isEmpty;
      _pinValidate = _pinController.text.isEmpty;
      _districtValidate = _districtController.text.isEmpty;

      if (_PasswordController.text != _ConfirmPasswordController.text) {
        _errorpasscontroller = true;
        _confirmValidate = false;
      } else {
        _errorpasscontroller = false;
      }

      if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(_emailController.text)) {
        _erroremail = true;
      } else {
        _erroremail = false;
      }

      if (!RegExp(r'^[0-9]{10}$').hasMatch(_phoneController.text)) {
        _errorphone = true;
      } else {
        _errorphone = false;
      }
      if (_PasswordController.text.length < 6) {
        _passwordcount = true;
      } else {
        _passwordcount = false;
      }
    });

    return !_nameValidate &&
        !_passValidate &&
        !_confirmValidate &&
        !_emailValidate &&
        !_phoneValidate &&
        !_addressValidate &&
        !_errorpasscontroller &&
        !_erroremail &&
        !_errorphone;
  }

  bool passVisible = true;

  void togglePasswordView() {
    setState(() {
      passVisible = !passVisible;
    });
  }

  Future<void> _addData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _PasswordController.text,
      );

      if (userCredential.user != null) {
        await _firestore.collection('partners').doc(userCredential.user!.uid).set({
          'username': _nameController.text.trim(),
          'password': _PasswordController.text.trim(),
          'email': _emailController.text.trim(),
          'phoneNumber': _phoneController.text.trim(),
          'address': _addressController.text.trim(),
          'pinNumber': _pinController.text.trim(),
          'district': _districtController.text.trim(),
          'status' : 'Active',
        });
        _nameController.clear();
        _PasswordController.clear();
        _ConfirmPasswordController.clear();
        _emailController.clear();
        _phoneController.clear();
        _addressController.clear();
        _pinController.clear();
        _districtController.clear();
      }
    } catch (e) {
      print('Error signing up: $e');
      // Handle sign-up errors here
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to sign up. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 60,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 1.4,
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
                            child: ListView(
                              children: [
                                TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      hintText: 'Name',
                                      errorText: _nameValidate
                                          ? 'Please Enter Name'
                                          : null,
                                      prefixIcon: Icon(Icons.person)
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      hintText: 'Email Address',
                                      errorText: _emailValidate
                                          ? 'Please Enter Email'
                                          : _erroremail
                                          ? 'Please Enter Valid Email'
                                          : null,
                                      prefixIcon: Icon(Icons.email)
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      hintText: 'Phone Number',
                                      errorText: _phoneValidate
                                          ? 'Please Enter Phone Number'
                                          : _errorphone
                                          ? 'Enter Valid Phone Number'
                                          : null,
                                      prefixIcon: Icon(Icons.phone)
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      hintText: 'Address',
                                      errorText:
                                      _addressValidate
                                          ? 'Please Enter Address'
                                          : null,
                                      prefixIcon: Icon(Icons.home)
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: _pinController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                    hintText: 'Pin Number',
                                    errorText:
                                    _pinValidate
                                        ? 'Please Enter Pin Number'
                                        : null,
                                    prefixIcon: Icon(Icons.pin_drop),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: _districtController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      hintText: 'District',
                                      errorText:
                                      _districtValidate
                                          ? 'Please Enter District'
                                          : null,
                                      prefixIcon: Icon(Icons.location_searching)
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: _PasswordController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      hintText: 'Enter Password',
                                      errorText: _passValidate
                                          ? 'Please Enter Password'
                                          : _passwordcount
                                          ? 'Password must be 6 characters'
                                          : null,
                                      suffixIcon: IconButton(
                                          icon: Icon(passVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              togglePasswordView();
                                            });
                                          }),
                                      prefixIcon: Icon(Icons.security)
                                  ),
                                  obscureText: passVisible,

                                ),
                                SizedBox(height: 10),
                                TextField(
                                  obscureText: true,
                                  controller: _ConfirmPasswordController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      hintText: 'Confirm Password',
                                      errorText: _confirmValidate
                                          ? 'Please Enter Password'
                                          : _errorpasscontroller
                                          ? 'Password not matching'
                                          : null,
                                      prefixIcon: Icon(Icons.security)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                if (validateFields()) {
                                  _addData();
                                  Center(
                                    child: Container(
                                      child: Lottie.network(
                                          'https://lottie.host/3b664beb-ed72-41bb-8530-14fc995af298/CD7Gf2LYm5.json'),
                                    ),
                                  );
                                  Future.delayed(Duration(seconds: 2), () {
                                    _districtController.clear();
                                    _pinController.clear();
                                    _addressController.clear();
                                    _phoneController.clear();
                                    _emailController.clear();
                                    _ConfirmPasswordController.clear();
                                    _PasswordController.clear();
                                    _nameController.clear();
                                    Fluttertoast.showToast(
                                        msg: 'Data added Successfully');
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return partnerManageHome();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(-1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;

                                          var tween = Tween(
                                              begin: begin, end: end).chain(
                                              CurveTween(curve: curve));

                                          var offsetAnimation = animation.drive(
                                              tween);

                                          return SlideTransition(
                                              position: offsetAnimation,
                                              child: child);
                                        },
                                        transitionDuration: Duration(
                                            milliseconds: 400),
                                      ),
                                    );
                                  });
                                }
                              });
                            },
                            child: Text('ADD', style: GoogleFonts.heebo(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  primaryColor),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  Size(MediaQuery
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
            ),
          ),
        ),
      );
    }
  }
