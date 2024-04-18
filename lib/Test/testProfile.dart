import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class profilestate extends StatefulWidget {
  final User user;
  profilestate({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<profilestate> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      DocumentSnapshot userData = await _firestore.collection('users').doc(widget.user.uid).get();
      if (userData.exists && userData.data() != null) {
        setState(() {
          _userData = userData.data() as Map<String, dynamic>;
        });
      } else {
        // Handle case where user data doesn't exist or is null
        print('User data does not exist or is null.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${_userData!['username']}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email: ${_userData!['email']}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Password: ${_userData!['password']}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}