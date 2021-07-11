import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_relief/get_donars.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Request extends StatefulWidget {
  @override
  _Request createState() => _Request();
}

class _Request extends State<Request> {
  var _formKey = GlobalKey<FormState>();
  var blood;
  var _name = TextEditingController();
  var _bloodgrp;
  var _number = TextEditingController();
  var _hospital = TextEditingController();

  var _enail = TextEditingController();
  var _city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade400,
          automaticallyImplyLeading: false,
          title: Text("Request Plasma"),
        ),
        body: Stack(children: <Widget>[
          // Container(
          //   height: size.height * 0.15,
          //   decoration: BoxDecoration(color: Colors.red.shade400),
          // ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Text(

                      //   "Request Plasma",

                      //   style: Theme.of(context)

                      //       .textTheme

                      //       .display1

                      //       .copyWith(fontWeight: FontWeight.w300),

                      // ),

                      SizedBox(
                        height: 80,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _name,
                                  decoration: InputDecoration(
                                    labelText: "Enter Full Name",
                                  ),
                                  validator: (value) => (value.isEmpty)
                                      ? "Please enter your name"
                                      : null,
                                  autofocus: false,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Enter your Eamil"),
                                  controller: _enail,
                                  validator: (value) => (value.isEmpty)
                                      ? "Please enter email id"
                                      : null,
                                  autofocus: false,
                                ),
                                DropdownButton<String>(
                                  focusColor: Colors.white,

                                  value: _bloodgrp,

                                  //elevation: 5,

                                  style: TextStyle(color: Colors.white),

                                  iconEnabledColor: Colors.black,

                                  items: <String>[
                                    'A(+/-)',
                                    'B(+/-)',
                                    'AB(+/-)',
                                    'O(+/-)'


                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),

                                  hint: Text(
                                    "Blood Group",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),

                                  onChanged: (String value) {
                                    setState(() {
                                      _bloodgrp = value;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller: _number,

                                  //obscureText: true,

                                  keyboardType: TextInputType.number,

                                  decoration: InputDecoration(
                                    labelText: "Enter Your Number",
                                  ),

                                  validator: (value) => (value.isEmpty)
                                      ? "Please Enter Number"
                                      : null,

                                  autofocus: false,
                                ),
                                TextFormField(
                                  controller: _city,

                                  //obscureText: true,

                                  decoration: InputDecoration(
                                    labelText: "Enter Your City",
                                  ),

                                  validator: (value) => (value.isEmpty)
                                      ? "Enter City Name"
                                      : null,

                                  autofocus: false,
                                ),
                                TextFormField(
                                  controller: _hospital,

                                  //obscureText: true,

                                  decoration: InputDecoration(
                                    labelText: "Enter Hospital Name",
                                  ),

                                  validator: (value) => (value.isEmpty)
                                      ? "Please enter Hospital Name"
                                      : null,

                                  autofocus: false,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text(
                                      "Requst",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      adddonars();

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Getdonar(_bloodgrp)));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]));
  }

  adddonars() async {
    await Firebase.initializeApp();
    CollectionReference user = FirebaseFirestore.instance
        .collection("Users")
        .doc("Request")
        .collection("Request");
    user.add({
      "name": _name.text,
      "email": _enail.text,
      "blood group": _bloodgrp,
      "Mobile no": _number.text,
      "city name": _city.text,
      "hospital name": _hospital.text
    });
  }
}
