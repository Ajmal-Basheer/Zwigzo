import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Admin/AdminHome.dart';
import 'package:foodapp/Admin/Order/AssignOrder.dart';
import 'package:foodapp/Admin/Order/OrderManageHome.dart';
import 'package:foodapp/Admin/Partner/PartnerManage.dart';
import 'package:foodapp/Admin/Partner/addPartner.dart';
import 'package:foodapp/Admin/Product/AddItem.dart';
import 'package:foodapp/Admin/Product/AdminItemList.dart';
import 'package:foodapp/Admin/Product/EditItemDetails.dart';
import 'package:foodapp/Admin/Product/ManageProduct.dart';
import 'package:foodapp/Admin/Product/UpdateCategory.dart';
import 'package:foodapp/Admin/Product/addCategory.dart';
import 'package:foodapp/Admin/Product/adminItemDetails.dart';
import 'package:foodapp/Admin/USER/userList.dart';
import 'package:foodapp/DeliveryPartner/DeliveryHome.dart';
import 'package:foodapp/DeliveryPartner/PartnerInsights.dart';
import 'package:foodapp/DeliveryPartner/PartnerPayOut.dart';
import 'package:foodapp/Screens/Buy/address.dart';
import 'package:foodapp/Screens/Buy/newAddress.dart';
import 'package:foodapp/Screens/Buy/placeOrder.dart';
import 'package:foodapp/Screens/Buy/successOrder.dart';
import 'package:foodapp/Screens/GetStart.dart';
import 'package:foodapp/Screens/Home.dart';
import 'package:foodapp/Screens/Items/Categories%20details.dart';
import 'package:foodapp/Screens/Items/ItemDetails.dart';
import 'package:foodapp/Screens/Items/PopularItem.dart';
import 'package:foodapp/Screens/Items/Wishlist.dart';
import 'package:foodapp/Screens/Items/itemsList.dart';
import 'package:foodapp/Screens/Items/newestList.dart';
import 'package:foodapp/Screens/Order/orderDetails.dart';
import 'package:foodapp/Screens/Payment/Payment.dart';
import 'package:foodapp/Screens/Profile/EditProfile.dart';
import 'package:foodapp/Screens/Profile/Profile.dart';
import 'package:foodapp/Screens/Sections/CategorySec.dart';
import 'package:foodapp/Screens/onBoarding/design.dart';
import 'package:foodapp/SignIn/Signin.dart';
import 'package:foodapp/SignUp/SignUp.dart';
import 'package:foodapp/Test/signup2.dart';
import 'package:foodapp/firebase_options.dart';
import 'package:foodapp/test.dart';

import 'Test/Login.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zwigzo',
      home: Signin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
