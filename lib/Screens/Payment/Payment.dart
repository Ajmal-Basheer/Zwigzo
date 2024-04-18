import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/Screens/Buy/address.dart';
import 'package:foodapp/Screens/Buy/placeOrder.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class payment extends StatefulWidget {
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double? totalprize;
  int ? quantity;
  payment(
      {required this.categoryDoc,
        required this.selectedItemID,
        required this.categoryName,
        required this.totalprize,
        required this.quantity,
      });

  @override
   paymentState createState()=>paymentState(
    categoryName: categoryName,
    categoryDoc: categoryDoc,
    selectedItemID: selectedItemID,
    totalprize: totalprize,
    quantity : quantity,
  );
}
class paymentState extends State {
  int selectedValue = 1;
  Razorpay? _razorpay;
  bool isCreating = false;
  late String _paymentmethod;
  final String categoryDoc;
  final String selectedItemID;
  final String categoryName;
  double? totalprize;
  int? quantity;

  paymentState(
      {required this.categoryDoc,
        required this.selectedItemID,
        required this.categoryName,
        required this.totalprize,
        required this.quantity,
      });


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS PAYMENT : ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "ERROR PAYMENT : ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {

  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment (String dynamic) async{

    var options = {
      'key':'rzp_test_o3XMIvTosfeSUc',
      'amount':100,
      'name':'Ajith',
      'description':'iphone 15',
      'prefill':{'contact':"+919633499659",'email':"ajith@gmail.com"},
    };

    try{
      _razorpay?.open(options);
    }
    catch(e){
      debugPrint(e.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: scaffoldBackgroundColor,
    appBar: AppBar(
      backgroundColor: primaryColor,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          child: Container(
                            child: Icon(Icons.done_outline_sharp,color: Colors.white,size: 12,),
                          ),
                        ),
                        Text('Address',style: TextStyle(fontSize: 12,color: Colors.black),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width/6,
                        height: 2,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        ),
                        Text('Payment',style: TextStyle(fontSize: 12,color: Colors.black),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width/6,
                        height: 2,
                        color: Color(0x56fdd301),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x56fdd301),
                          ),
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        ),
                        Text('Place Order',style: TextStyle(fontSize: 12,color: Colors.black54),)
                      ],
                    ),
                  ]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              'Select a Payment Method',
              style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: .1,
                    color: Colors.black,
                  ),
                ]),
            child:  Column(
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Radio(
              value: 1,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as int;
                });
              },
            ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'Cash on Delivery',
                    style:
                    TextStyle( fontSize: 16),
                  ),
                ]
                  )
                )
          ]
            )
              ]
          ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: .1,
                    color: Colors.black,
                  ),
                ]),
            child:  Column(
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Radio(
              value: 2,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as int;
                });
              },
            ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'Online Payment',
                    style:
                    TextStyle( fontSize: 16),
                  ),
                ]
                  )
                )
          ]
            )
              ]
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Continue', style: GoogleFonts.heebo(
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
              onPressed: (){
                if (selectedValue != 2){
                  setState(() {
                    _paymentmethod = 'Cash On Delivery';
                  });
                  Navigator.push(context,  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return placeorder(categoryDoc: categoryDoc,
                        selectedItemID: selectedItemID,
                        categoryName: categoryName,
                        totalprize: totalprize,
                        quantity: quantity,
                        paymentMethod: _paymentmethod,);
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(position: offsetAnimation, child: child);
                    },
                    transitionDuration: Duration(milliseconds: 400),
                  ),
                  );
                }else{
                  setState(() {
                    _paymentmethod = 'Online Payment';
                  });
                 makePayment;
                }
              },
            ),
          )
    ]
      ),
    ),
  );
}
}
//0x56fdd301