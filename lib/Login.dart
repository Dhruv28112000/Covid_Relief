import 'package:covid_relief/Homepage.dart';
import 'package:covid_relief/signup.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:saloon_booking/homepage.dart';
//import 'package:saloon_booking/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  User currentUser;
  String _email, _password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  //Color greenColor = Color(0xFF00AF50);

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        //backgroundColor: Colors.redAccent,

        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: _formStateKey, child: _buildLoginForm())));
  }

  _buildLoginForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(children: [
                Text('Covid Relief',
                    style: TextStyle(
                        fontFamily: 'Trueno',
                        fontSize: 30.0,
                        color: Colors.redAccent)),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('Made with ❤️ in India 🇮🇳',
                        style: TextStyle(
                          fontFamily: 'Trueno',
                          fontSize: 15.0,
                        ))),
              ])),
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
                this._email = value;
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
          SizedBox(height: 5.0),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => {}));
              },
              child: Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                      child: Text('Forgot Password',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontFamily: 'Trueno',
                              fontSize: 11.0,
                              decoration: TextDecoration.underline))))),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              // if (checkFields()) AuthService().signIn(email, password, context);
              if (_formStateKey.currentState.validate()) {
                _formStateKey.currentState.save();
                signIn(_email, _password).then((user) async {
                  if (user != null) {
                    print('Logged in successfully.');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('email', _email);
                    print(_email);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => Homepage(_email),
                      ),
                    );
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
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              //AuthService().fbSignIn();
              googleSignin(context).then((user) {
                if (user != null) {
                  print('Logged in successfully.');
                  setState(() {
                    isGoogleSignIn = false;
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => Homepage(currentUser.displayName),
                      ),
                    );
                  });
                } else {
                  print('Error while Login.');
                }
              });
            },
            child: Container(
                height: 50.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google),
                      // Center(
                      //     child: ImageIcon(AssetImage('assets/facebook.png'),
                      //         size: 15.0)),
                      SizedBox(width: 10.0),
                      Center(
                          child: Text('Login with Google',
                              style: TextStyle(fontFamily: 'Trueno'))),
                    ],
                  ),
                )),
          ),
          SizedBox(height: 25.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('New to App ?'),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text('Register',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }

  Future<User> signIn(String email, String password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<User> googleSignin(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await auth.signInWithCredential(credential)).user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      currentUser = await auth.currentUser;
      assert(user.uid == currentUser.uid);
      print(currentUser);
      print(currentUser.phoneNumber);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UserName', "${currentUser.displayName}");
      print("User Name  : ${currentUser.displayName}");
    } catch (e) {
      handleError(e);
    }
    return currentUser;
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found!!!';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password!!!';
        });
        break;
    }
  }
}
