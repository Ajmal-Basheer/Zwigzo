import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/Admin/Partner/deletePArtner.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/loading.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:lottie/lottie.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
CollectionReference partners = firebaseFirestore.collection('partners');

class partnersList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => partnersListState();
}
class partnersListState extends State {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: scaffoldBackgroundColor,
     body: Padding(
       padding: const EdgeInsets.all(15),
       child: Container(
         padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
         child:  StreamBuilder(
           stream: partners.snapshots(),
           builder: (context, snapshot) {
             if (snapshot.hasError) {
               return Text('Something went wrong');
             }

             if (snapshot.connectionState ==
                 ConnectionState.waiting) {
               return loading();
             }
           return HorizontalDataTable(
             leftHandSideColumnWidth: 100,
             rightHandSideColumnWidth: 470,
             isFixedHeader: true,
             headerWidgets: _getTitleWidget(),
             leftSideItemBuilder: _generateFirstColumnRow,
             rightSideItemBuilder: _generateRightHandSideColumnRow,
             itemCount:snapshot.data!.docs.length,
             rowSeparatorWidget: const Divider(
               color: Colors.black38,
               height: 1.0,
               thickness: 0.0,
             ),
             leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
             rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
           );
  }
           ),
         ),
       ),
   );
  }
}
List<Widget> _getTitleWidget() {
  return [
    _getTitleItemWidget('Name', 100),
    _getTitleItemWidget('Status', 120),
    _getTitleItemWidget('Pin', 100),
    _getTitleItemWidget('District', 100),
    _getTitleItemWidget('Phone', 100),
    _getTitleItemWidget('Delete', 50),
  ];
}

Widget _getTitleItemWidget(String label, double width) {
  return Container(
    width: width,
    height: 56,
    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.centerLeft,
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
Widget _generateFirstColumnRow(BuildContext context, int index) {
  return StreamBuilder(
    stream: partners.snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Text('No data');
      }

      // Ensure that the index is within the bounds of the docs list
      if (index >= snapshot.data!.docs.length) {
        return SizedBox.shrink(); // Return an empty widget if the index is out of range
      }

      // Use the document at the specified index
      DocumentSnapshot document = snapshot.data!.docs[index];

      return Container(
        width: 100,
        height: 52,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
        // Use the correct field name
        child: Text(document['username']),
      );
    },
  );
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return StreamBuilder(
    stream: partners.snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Text('No data');
      }

      // Ensure that the index is within the bounds of the docs list
      if (index >= snapshot.data!.docs.length) {
        return SizedBox.shrink(); // Return an empty widget if the index is out of range
      }

      // Use the document at the specified index
      DocumentSnapshot document = snapshot.data!.docs[index];

      // Use the correct field name
      String status = document['status'];

      return Row(
        children: <Widget>[
          Container(
            width: 120,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                status == 'Active'
                    ? Text('Active')
                    : status == 'Offline'
                    ? Text('Offline')
                    : Text('On Delivery'),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.circle,
                    color: status == 'Active' ? Colors.green : status == 'Offline' ? Colors.red : Colors.blue,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(document['pinNumber']),
          ),
          Container(
            width: 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(document['district']),
          ),
          Container(
            width: 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(document['phoneNumber']),
          ),
          Container(
            width: 50,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                deletepartner(document.id);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}
