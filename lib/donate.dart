import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Donate extends StatefulWidget {
  @override
  _Donate createState() => _Donate();
}

class _Donate extends State<Donate> {
  var _formKey = GlobalKey<FormState>();

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
        title: Text("Donate Plasma"),
      ),
        body: Stack(children: <Widget>[
  
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
         
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
                          validator: (value) =>
                              (value.isEmpty) ? "Please enter your name" : null,
                          autofocus: false,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "Enter your Eamil"),
                          controller: _enail,
                          validator: (value) =>
                              (value.isEmpty) ? "Please enter email id" : null,
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
                          ].map<DropdownMenuItem<String>>((String value) {
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
                          validator: (value) =>
                              (value.isEmpty) ? "Please Enter Number" : null,
                          autofocus: false,
                        ),
                        TextFormField(
                          controller: _city,
                          //obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Enter Your City",
                          ),
                          validator: (value) =>
                              (value.isEmpty) ? "Enter City Name" : null,
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
                              "Donate",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                            onPressed: () {
                              adddonars();
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
        ),
        )
      )
    ]));
  }

  adddonars() async {
    await Firebase.initializeApp();
    CollectionReference user = FirebaseFirestore.instance.collection("Users");
    user.doc("Donars").collection("Donars").add({
      "name": _name.text,
      "email": _enail.text,
      "blood group": _bloodgrp,
      "Mobile no": _number.text,
      "city name": _city.text,
      "hospital name": _hospital.text
    });
  }
}
