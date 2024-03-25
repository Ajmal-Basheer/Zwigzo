import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class addCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => addCategoryState();
}

class addCategoryState extends State {

  final TextEditingController _categoryContoller = TextEditingController();
  PlatformFile? pickedfile;
  PlatformFile? pickedBgfile;
  String imageURL = '' ;
  String BgURL = '' ;
  String Categorysubcollection = '';


  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );
    if (result == null) return;
    setState(() {
      pickedfile = result.files.first;
      Fluttertoast.showToast(msg: 'File Selected Successfully');
    });
  }
  Future selectBgFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null) return;
    setState(() {
      pickedBgfile = result.files.first;
      Fluttertoast.showToast(msg: 'File Selected Successfully');
    });
  }
  Future uploadBgFile() async {
    if (pickedBgfile == null) return;

    final path = 'assets/${pickedBgfile!.name}';
    final file = File(pickedBgfile!.path!);

    try {
      await FirebaseStorage.instance.ref(path).putFile(file);
      final url = await FirebaseStorage.instance.ref(path).getDownloadURL();
      setState(() {
        if (url.isNotEmpty) {
          BgURL = url;
        }
      });
      print('File Upload Successfully');
      Fluttertoast.showToast(msg: 'File Upload Successfully');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }
  Future uploadFile() async {
    if (pickedfile == null) return;

    final path = 'assets/${pickedfile!.name}';
    final file = File(pickedfile!.path!);

    try {
      await FirebaseStorage.instance.ref(path).putFile(file);
      final url = await FirebaseStorage.instance.ref(path).getDownloadURL();
      setState(() {
        if(url.isNotEmpty){
          imageURL = url;
        }
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }
  Future<void> _addData() async {
    try {
      if (imageURL.isEmpty) {
        // Display an error message to the user
        print('Image URL is empty');
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference products = firestore.collection('foodCategory');

      // Add the main document
      await products.add({
        'categoryName': _categoryContoller.text,
        'CatimageLink': BgURL,
        'CatimgPng' : imageURL,
      });
      // Clear text field controllers after adding data
      _categoryContoller.clear();
      // Optionally, you can also display a success message or navigate to another screen
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body:  SafeArea(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Add Category',
                    style: GoogleFonts.dmSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _categoryContoller,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Enter Category Type',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextButton(
                     onPressed: (){
                       selectFile();
                     },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('choose file',style: TextStyle(color: Colors.black),),
                        SizedBox(width: 5,),
                        pickedfile == null
                            ? Text('(png file only)', style: TextStyle(color: Colors.red, fontSize: 10),)
                            : Text('(file Selected)', style: TextStyle(color: Colors.green, fontSize: 10)),
                      ],
                    ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextButton(
                     onPressed: (){
                       selectBgFile();
                     },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('choose Bg file',style: TextStyle(color: Colors.black),),
                        SizedBox(width: 5,),
                        pickedBgfile == null
                            ? Text('(Image file for Bg)', style: TextStyle(color: Colors.red, fontSize: 10),)
                            : Text('(file Selected)', style: TextStyle(color: Colors.green, fontSize: 10)),
                      ],
                    ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ElevatedButton(
                  child: Text('Submit', style: GoogleFonts.heebo(
                      color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(primaryColor),
                    fixedSize:
                    MaterialStateProperty.all<Size>(Size(MediaQuery
                        .of(context)
                        .size
                        .width - 40, 50)),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await uploadFile();
                    uploadBgFile();
                    _addData();
                    Fluttertoast.showToast(msg: 'Category Added Successfully');
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
