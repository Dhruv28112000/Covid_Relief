import 'package:covid_relief/Homepage.dart';
import 'package:covid_relief/Login.dart';
//import 'package:covid_relief/Start.dart';
import 'package:covid_relief/donate.dart';
import 'package:covid_relief/get_donars.dart';
import 'package:covid_relief/request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

     await Firebase.initializeApp();
  runApp(MyApp());

   

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
          
      debugShowCheckedModeBanner: false,
      title: 'Covid Relief',
      theme: ThemeData(
        primarySwatch: Colors.blue,
       fontFamily: "Cairo",
        //scaffoldBackgroundColor: kBackgroundColor,
       // textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: Login()

    
    );
  }
}


