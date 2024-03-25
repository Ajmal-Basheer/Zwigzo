import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AssignOrderState();
}

class AssignOrderState extends State {
  String ? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Assign Order',
          style: GoogleFonts.jost(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Order Details',
                  style: GoogleFonts.dmSans(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.black12,
                        offset: Offset(1, 3)
                    )
                  ]
              ),
              child:
              Container(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text('1 x',style:GoogleFonts.roboto(fontSize: 18),),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Zwigzo Biriyani',
                                        style: GoogleFonts.roboto(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
                                    child: Container(
                                      padding:  EdgeInsets.fromLTRB(10, 2, 10, 2),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.red,width: 1,)
                                      ),
                                      child: Text('CASH',style: TextStyle(color: Colors.red),),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                    child: Container(
                                      padding:  EdgeInsets.fromLTRB(10, 2, 10, 2),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.blue,width: 1,)
                                      ),
                                      child: Text('₹ 150',style: TextStyle(color: Colors.blue),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container (
                        child: Dash(
                            direction: Axis.vertical,
                            length: 120,
                            dashLength: 15,
                            dashColor: Colors.grey.shade400),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ajmal Basheer',
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('Valiyavila puthen veedu'),
                              Text('690520'),
                              Text('kollam'),
                              Text('8606070030'),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Select Delivery Partner',
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
                child:DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      '---Select---',
                      style: TextStyle(color: Colors.grey[600]), // Set hint text color
                    ),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down), // Add an arrow icon
                    iconSize: 24, // Set the size of the arrow icon
                    elevation: 16, // Add elevation to the dropdown menu
                    style: TextStyle(color: Colors.black), // Set text color of selected option
                    underline: Container( // Customize the underline decoration
                      height: 2,
                      color: Colors.grey[400], // Set the color of the underline
                    ),
                    items: <String>['Arun', 'Riya', 'Adhi']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black), // Set text color of dropdown options
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ElevatedButton(
                child: Text('Assign Order', style: GoogleFonts.heebo(
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
