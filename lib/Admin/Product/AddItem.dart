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

class addItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => addItemState();
}

class addItemState extends State {
  String? CategorydropdownValue;
  String? RatingdropdownValue;
  late TextEditingController _itemname;
  late TextEditingController _itemprize;
  PlatformFile? pickedfile;
  PlatformFile? pickedBgfile;
  String imageURL = '';
  String BgURL = '';
  late TextEditingController _discription;

  @override
  void initState() {
    super.initState();
    _itemname = TextEditingController();
    _itemprize = TextEditingController();
    _discription = TextEditingController();
  }

  @override
  void dispose() {
    _itemname.dispose();
    _itemprize.dispose();
    _discription.dispose();
    super.dispose();
  }

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

  Future uploadFile() async {
    if (pickedfile == null) return;

    final path = 'assets/${pickedfile!.name}';
    final file = File(pickedfile!.path!);

    try {
      await FirebaseStorage.instance.ref(path).putFile(file);
      final url = await FirebaseStorage.instance.ref(path).getDownloadURL();
      setState(() {
        if (url.isNotEmpty) {
          imageURL = url;
        }
      });
      print('File Upload Successfully');
      Fluttertoast.showToast(msg: 'File Upload Successfully');
    } catch (e) {
      print('Error uploading file: $e');
    }
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

  Future<void> _addData() async {
    try {
      // Check if imageURL is empty
      if (imageURL.isEmpty) {
        // Display an error message to the user
        print('Png URL is empty');
        return;
      }
      if(BgURL.isEmpty){
        print('Bg URL is empty');
      }


      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot categorySnapshot =
      await firestore.collection('foodCategory').get();

      String? categoryId;
      for (DocumentSnapshot doc in categorySnapshot.docs) {
        String categoryName =
        (doc['categoryName'] as String).trim().toLowerCase();
        String selectedCategory = CategorydropdownValue?.trim().toLowerCase() ?? '';

        if (categoryName == selectedCategory) {
          categoryId = doc.id;
          break;
        }
      }

      if (categoryId == null) {
        print('Selected category not found');
        return;
      }

      print('Selected category id: $categoryId');

      // Get reference to the sub-collection under the selected category
      CollectionReference items = firestore
          .collection('foodCategory')
          .doc(categoryId)
          .collection('${CategorydropdownValue}Items');

      // Add data to Firestore
      await items.add({
        'itemName': _itemname.text,
        'itemImagelink': imageURL,
        'rupees': _itemprize.text,
        'rating': RatingdropdownValue,
        'discription': _discription.text,
        'itemBg' : BgURL,
      });
      pickedfile = null;
      _itemname.clear();
      _itemprize.clear();
      CategorydropdownValue = null;
      RatingdropdownValue = null;
      Fluttertoast.showToast(msg: 'Item Added Successfully');
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error adding data: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Select Category',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child:StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('foodCategory').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return loading();
                        }

                        List<String> categoryNames = snapshot.data!.docs
                            .map((doc) => doc['categoryName'] as String)
                            .toSet()
                            .toList();

                        return DropdownButton<String>(
                          hint: Text('Select a category'),
                          value: CategorydropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              CategorydropdownValue = newValue!;
                              print('Selected category value: $CategorydropdownValue');
                            });
                          },
                          items: categoryNames
                              .map<DropdownMenuItem<String>>((String Value) {
                            return DropdownMenuItem<String>(
                              value: Value,
                              child: Text(Value),
                            );
                          }).toList(),
                        );
                      },
                    )

                  )
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Enter Item Name',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextField(
                  controller: _itemname,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter Item Name',
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Enter Amount',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextField(
                  controller: _itemprize,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Enter Item Discription',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextField(
                  controller: _discription,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter Discription',
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Select Rating',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      '----Select----',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    value: RatingdropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        RatingdropdownValue = newValue!;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey[400],
                    ),
                    items: <String>[
                      '1',
                      '1.5',
                      '2',
                      '2.5',
                      '3',
                      '3.5',
                      '4',
                      '4.5',
                      '5',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Text(
                  'Add Item Png',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {
                    selectFile();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'choose file',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      pickedfile == null
                          ? Text('(png file only)',
                              style: TextStyle(color: Colors.red, fontSize: 10))
                          : Text('(file Selected)',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Text(
                  'Add Item Image',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {
                    selectBgFile();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'choose file',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      pickedBgfile == null
                          ? Text('(File For Bg)',
                              style: TextStyle(color: Colors.red, fontSize: 10))
                          : Text('(file Selected)',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ElevatedButton(
                child: Text('Add Item',
                    style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width - 40, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  await uploadFile();
                  uploadBgFile();
                  _addData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
