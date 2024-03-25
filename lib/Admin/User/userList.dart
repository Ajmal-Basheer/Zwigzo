import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:lottie/lottie.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('users');

class UsersList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UsersListState();
}

class UsersListState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Users List',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: users.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    DocumentSnapshot? document = snapshot.data?.docs[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3,
                      margin: EdgeInsets.all(7),
                      child: ListTile(
                        title: Text(document?['username']),
                        subtitle: Text(document?['email']),
                        trailing:  Text(document?['pinNumber']),
                      ),
                    );
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}