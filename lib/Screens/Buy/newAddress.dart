import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Screens/Buy/address.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class newAddress extends StatefulWidget {  @override
  State<StatefulWidget> createState() =>newAddressState();
}
class newAddressState extends State {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _pinController;
  late final TextEditingController _districtController;

  bool _nameValidate = false;
  bool _phoneValidate = false;
  bool _pinValidate = false;
  bool _districtValidate = false;
  bool _addressValidate = false;
  bool _errorphone = false;
  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _pinController = TextEditingController();
    _districtController = TextEditingController();
    super.initState();
  }

  // Function to validate all fields
  bool validateFields() {
    setState(() {
      _nameValidate = _nameController.text.isEmpty;
      _phoneValidate = _phoneController.text.isEmpty;
      _addressValidate = _addressController.text.isEmpty;
      _pinValidate = _pinController.text.isEmpty;
      _districtValidate = _districtController.text.isEmpty;


      if (!RegExp(r'^[0-9]{10}$').hasMatch(_phoneController.text)) {
        _errorphone = true;
      } else {
        _errorphone = false;
      }
    });

    return !_nameValidate &&
        !_phoneValidate &&
        !_addressValidate &&
        !_errorphone ;
  }
  bool passVisible = true;

  void togglePasswordView() {
    setState(() {
      passVisible = !passVisible;
    });
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
                SizedBox(height: 70,),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height /1.8,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Text('Add New Address',style: GoogleFonts.roboto(fontSize: 20),),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                    hintText: 'Name',
                                    errorText: _nameValidate ? 'Please Enter Name' : null,
                                    prefixIcon: Icon(Icons.person)
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(color: Colors.black, width: 1),
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
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                    hintText: 'Address',
                                    errorText:
                                    _addressValidate ? 'Please Enter Address' : null,
                                    prefixIcon: Icon(Icons.home)
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _pinController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(color: Colors.black, width: 1),
                                  ),
                                  hintText: 'Pin Number',
                                  errorText:
                                  _pinValidate ? 'Please Enter Pin Number' : null,
                                  prefixIcon: Icon(Icons.pin_drop),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _districtController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                    hintText: 'District',
                                    errorText:
                                    _districtValidate ? 'Please Enter District' : null,
                                    prefixIcon: Icon(Icons.location_searching)
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    if (validateFields()) {
                                      _districtController.clear();
                                      _pinController.clear();
                                      _addressController.clear();
                                      _phoneController.clear();
                                      _nameController.clear();
                                      // Navigator.push(
                                      //   context,
                                      //   PageRouteBuilder(
                                      //     pageBuilder: (context, animation,
                                      //         secondaryAnimation) {
                                      //       return address();
                                      //     },
                                      //     transitionsBuilder: (context, animation,
                                      //         secondaryAnimation, child) {
                                      //       const begin = Offset(-1.0, 0.0);
                                      //       const end = Offset.zero;
                                      //       const curve = Curves.easeInOut;
                                      //
                                      //       var tween = Tween(
                                      //           begin: begin, end: end).chain(
                                      //           CurveTween(curve: curve));
                                      //
                                      //       var offsetAnimation = animation.drive(
                                      //           tween);
                                      //
                                      //       return SlideTransition(
                                      //           position: offsetAnimation,
                                      //           child: child);
                                      //     },
                                      //     transitionDuration: Duration(
                                      //         milliseconds: 400),
                                      //   ),
                                      // );
                                    }
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
