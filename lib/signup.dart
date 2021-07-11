import 'package:covid_relief/Homepage.dart';
import 'package:covid_relief/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
//import 'package:saloon_booking/Login.dart';
//import 'package:saloon_booking/homepage.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  User currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //final fb = FirebaseDatabase.instance.reference().child("Users");
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _name = TextEditingController(text: '');

  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  //To check fields during submit
  checkFields() {
    final form = _formStateKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: _formStateKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Signup',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 62.0,
                      left: 200.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.redAccent)))
                ],
              )),
          SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  )),
              onChanged: (value) {
                this._emailId = value;
              },
              validator: (value) =>
                  value.isEmpty ? 'Email is required' : validateEmail(value)),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  )),
              obscureText: true,
              onChanged: (value) {
                this._password = value;
              },
              validator: (value) =>
                  value.isEmpty ? 'Password is required' : null),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'CONFIRM PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  )),
              obscureText: true,
              onChanged: (value) {
                this._password = value;
              },
              validator: (value) =>
                  value.isEmpty ? 'Password is required' : null),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              // if (checkFields())
              //   AuthService().signUp(email, password).then((userCreds) {
              //     Navigator.of(context).pop();
              //   }).catchError((e) {
              //     ErrorHandler().errorDialog(context, e);
              //   });
              if (_formStateKey.currentState.validate()) {
                _formStateKey.currentState.save();
                signUp(_emailId, _password).then((user) async {
                  if (user != null) {
                    print('Registered Successfully.');
                    setState(() {
                      successMessage =
                          'Registered Successfully.\nYou can now navigate to Login Page.';
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => Homepage(_emailId.toString()),
                        ),
                      );
                    });
                  } else {
                    print('Error while Login.');
                  }
                });
              }
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.redAccent,
                    elevation: 7.0,
                    child: Center(
                        child: Text('SIGN UP',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }

  Future<User> signUp(email, password) async {
    //fb.child(_emailId).set(true).then((value){print("Done");});
    try {
      User user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      //String userid =user.uid;
      //fb.child(user.uid).set(true).then((value) {
      // print("Done");
      // });
      currentUser = await auth.currentUser;
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }
}
