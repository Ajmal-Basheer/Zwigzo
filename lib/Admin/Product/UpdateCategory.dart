import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class updateCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => updateCategoryState();
}
class updateCategoryState extends State<updateCategory> {
  CollectionReference<Map<String, dynamic>> firestore = FirebaseFirestore.instance.collection('foodCategory');
  final TextEditingController _categoryContoller = TextEditingController();
  PlatformFile? pickedfile;
  String imageURL = '' ;

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

  Future<void> categoryUpdate(String documentid, String newCategoryName, String newCatImageLink) async {
    Map<String, dynamic> updateData = {};

    DocumentSnapshot document = await firestore.doc(documentid).get();

    if (newCategoryName.isNotEmpty && newCategoryName != document['categoryName']) {
      updateData['categoryName'] = newCategoryName;
    }

    if (newCatImageLink.isNotEmpty && newCatImageLink != document['CatimageLink']) {
      updateData['CatimageLink'] = newCatImageLink;
    }

    if (updateData.isNotEmpty) {
      await firestore.doc(documentid).update(updateData);
      print('Category Update Successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Update Category',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body:  SafeArea(
        child: StreamBuilder(
            stream: firestore.snapshots(),
            builder: (context, snapshot){
             if (snapshot.hasError) {
               return Text('Something went wrong');
             }

             if (snapshot.connectionState == ConnectionState.waiting) {
               return loading();
             }
              DocumentSnapshot document = snapshot.data!.docs[0];
              return  Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Update Category',
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
                    hintText: document['categoryName'],
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
                  categoryUpdate(
                      document.id,
                      _categoryContoller.text,
                      imageURL
                  );
                  pickedfile = null;
                  Fluttertoast.showToast(msg: 'Category Added Successfully');
                },
              ),
            ),
          ],
              );
            }
        )
      ),
    );
  }
}
