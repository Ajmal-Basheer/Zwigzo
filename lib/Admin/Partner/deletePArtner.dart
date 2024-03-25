import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/Admin/Partner/partnersList.dart';

Future<void> deletepartner(String documentId) async {
  bool _isDeleting = false;
  try {
    setState(() {
      _isDeleting = true;
    });
    await partners.doc(documentId).delete();
    print('Partner deleted successfully!');
    Fluttertoast.showToast(msg: 'Partner deleted successfully');
  } catch (e) {
    // Handle any errors
    print('Error Partner category: $e');
    Fluttertoast.showToast(msg: 'Partner deleting failed');
  } finally {
    setState(() {
      _isDeleting = false;
    });
  }
}

void setState(Null Function() param0) {
}