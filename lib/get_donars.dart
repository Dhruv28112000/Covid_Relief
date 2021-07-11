//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
//import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';
//import 'package:userprofile_demo/Services/AuthenticationService.dart';

class Getdonar extends StatefulWidget {
  final bloodgrp;

  Getdonar(this.bloodgrp);

  @override
  _Getdonar createState() => _Getdonar(bloodgrp);
}

class _Getdonar extends State<Getdonar> {
TwilioFlutter twilioFlutter;
  final bloodgrp;

  _Getdonar(this.bloodgrp);

  
  

  dynamic data = [];
  Future _data;
  String name;
  String currentUserNumber;
  int count = 0;

 // bool get bloodgrp => bloodgrp;
  void initState() {
 twilioFlutter = TwilioFlutter(
        accountSid: 'AC4502d6a6244600e20786f245b4cb6047',
        authToken: '9feb9d1d87a87fcd224c5fe4666979e9',
        twilioNumber: '+19189922347');  
    // total = 0;
    //getFriend();
    _data = getData();
    super.initState();
  }

  getData() async {
    await Firebase.initializeApp();
    var details = FirebaseFirestore.instance;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //String email = prefs.getString('email');
    if(bloodgrp.toString()=="A(+/-)" ){    
      QuerySnapshot qn1 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "A(+/-)")

        .get();

              QuerySnapshot qn2 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "AB(+/-)")

        .get();
         return qn1.docs+qn2.docs;
    }
        else if(bloodgrp.toString()=="AB(+/-)" ){    
      QuerySnapshot qn1 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "A(+/-)")

        .get();

             
        
         return qn1.docs;
    }
      else  if(bloodgrp.toString()=="B(+/-)" ){    
      QuerySnapshot qn1 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "B(+/-)")

        .get();

              QuerySnapshot qn2 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "AB(+/-)")

        .get();
         return qn1.docs+qn2.docs;
    }
      else  if(bloodgrp.toString()=="O(+/-)" ){    
      QuerySnapshot qn1 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "A(+/-)")

        .get();
         QuerySnapshot qn2 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "B(+/-)")

        .get();
         QuerySnapshot qn3 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "O(+/-)")

        .get();



              QuerySnapshot qn4 = await details
        .collection('Users')
        .doc("Donars")
        .collection('Donars')
        .where("blood group" , isEqualTo: "AB(+/-)")

        .get();
         return qn1.docs+qn2.docs+qn3.docs+qn4.docs;
    }
    
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        automaticallyImplyLeading: false,
        title: Text("List of Donars"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: _data,
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                if (snapshot.data != null) {
                  if (snapshot.data.length > 0) {
                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(5),
                        clipBehavior: Clip.hardEdge,
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.white,
                              height: 20,
                              thickness: 0,
                            ),
                        shrinkWrap: false,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data[index].toString();
                          return Card(
                              key: Key(item),
                              child: Container(
                                child: ListTile(
                                    leading: Image.asset(
                                      "images/blood.png",
                                    ),
                                    // trailing: Text(
                                    //     '\u20B9' +
                                    //         snapshot.data[index]
                                    //             .data()['amount'],
                                    //     style: TextStyle(
                                    //         color: snapshot.data[index]
                                    //                     .data()['from'] ==
                                    //                 currentUserNumber
                                    //             ? Colors.green
                                    //             : Colors.red,
                                    //         fontFamily: 'Muli',
                                    //         fontWeight: FontWeight.bold,
                                    //         fontSize:
                                    //             15 )),
                                    title: Text.rich(
                                      TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: 'Name : ' +
                                                snapshot.data[index]
                                                    .data()['name'],
                                            style: TextStyle(
                                              fontFamily: 'Muli',
                                              fontSize: (20),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text.rich(
                                      TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: 'Blood Group  : ' +
                                                  snapshot.data[index]
                                                      .data()['blood group']),
                                        ],
                                      ),
                                    ),
                                    onTap: () => {
                                          // navigateToDetail(snapshot.data[index]),
                                          _displayDialog(snapshot.data[index]),
                                        }),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 6,
                                      offset: Offset(-4, 4),
                                    ),
                                  ],
                                ),
                              ));
                        });
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Center(
                       ),
                        Text(
                          'No Donar Yet!!!',
                          style: TextStyle(
                            fontFamily: 'Muli',
                            color: Colors.grey,
                             fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ));
                  }
                }
              }
            }),
      ),
    );
  }
   _displayDialog(index) {
     showDialog(
        context: context,
        barrierDismissible: false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 12),
                Text(
                  'Details of the Donar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 12),
                Text(
                  'Name : ' + index.data()["name"],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
                    SizedBox(height: 12),
                Text(
                  'Mobile Number : ' + index.data()["Mobile no"],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 12),
                   Text(
                  'City Name : ' + index.data()["city name"],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
                        SizedBox(height: 12),
                   Text(
                  'Hospital Name: ' + index.data()["hospital name"],
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 15),
                ),
                    SizedBox(height: 12),
                   Text(
                  'Blood Group: ' + index.data()["blood group"],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
                     SizedBox(height: 12),
                   Text(
                  'Email Address: ' + index.data()["email"].trim(),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
                  SizedBox(height: 20),
              RaisedButton(
                            child: Text(
                              "Send Details to Donar",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                            onPressed: () {
                             // adddonars();
                        //  sendSms();                     // Navigator.of(context).pop();
                            },
                          ),
              ],
            ),
          ),
        ),
      );
   
    void sendSms() async {
  
    twilioFlutter.sendSMS(
        toNumber: '+919409168958',
        messageBody: 'My Name is Ketul Mehta-18IT063');
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);
    await twilioFlutter.getSMS('Dhruv');
  }
}
}


