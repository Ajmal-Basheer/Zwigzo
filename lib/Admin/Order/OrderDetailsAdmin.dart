import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/Timeline.dart';
import 'package:foodapp/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class adminOrderDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => adminOrderDetailsState();
}
class adminOrderDetailsState extends State {
  String ? firstdropdownValue;
  String ? seconddropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Order Details', style: GoogleFonts.jost(fontSize: 20),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 3.6,
                            child: Image.network(
                                'https://img.freepik.com/premium-photo/bowl-food-with-piece-meat-vegetables-it_867452-673.jpg')),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Zwigzo Biriyani',
                              style: GoogleFonts.fjallaOne(fontSize: 18,),
                            ),
                            Text('Qty : 1', style: GoogleFonts.poppins(),),

                            SizedBox(height: 5),
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
                    ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(30, 20, 10, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ajmal Basheer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          Text('Valiyavila puthen veedu'),
                          Text('690520'),
                          Text('kollam'),
                          Text('8606070030'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Container(
                            padding:  EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.blue,width: 1,)
                            ),
                            child: Text('View Location',style: TextStyle(color: Colors.blue),),
                          )
                      ),
                      onTap: (){
                        _launchURL();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                padding: EdgeInsets.fromLTRB(30, 0, 130, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child:DropdownButton<String>(
                  hint: Text(
                    'Select Order Update',
                    style: TextStyle(color: Colors.grey[600]), // Set hint text color
                  ),
                  value: firstdropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      firstdropdownValue = newValue!;
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
                  items: <String>['Accepted', 'Out For Delivery', 'Delivered']
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    timeLineTwo(isFirst: true,
                      isLast: false,
                      isPast: true,
                      eventCard:Text('Accepted',style: GoogleFonts.abel(
                          fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),),),
                    timeLineTwo(isFirst: false,
                      isLast: false,
                      isPast: false,
                      eventCard: Text('Out For Delivery',style: GoogleFonts.abel(
                          fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),),
                    ),
                    timeLineTwo(
                      isFirst: false,
                      isLast: true,
                      isPast: false,
                      eventCard: Text("Delivered",style: GoogleFonts.abel(
                          fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 40,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                padding: EdgeInsets.fromLTRB(30, 0, 130, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  hint: Text(
                    'Select Payment Update',
                    style: TextStyle(color: Colors.grey[600]), // Set hint text color
                  ),
                  value: seconddropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      seconddropdownValue = newValue!;
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
                  items: <String>['Online', 'Recieved',]
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
          ],
        ),
      ),
    );
  }
  _launchURL() async {
    const url = 'https://maps.app.goo.gl/edifXJC7rHQAuxAUA'; // Replace with your URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}