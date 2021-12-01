import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
import 'package:myapp/insert.dart';
//import 'package:myapp/get.dart';
import 'package:myapp/splace-screen.dart';

//import 'package:myapp/splace-screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
//home: MyApp(),
    routes: {
      "/": (context) => SplaceScreen(),
      //"/": (context) => SplaceScreen(),
      "/home": (context) => HomePage(),
      "/insert": (context) => InsertRoute(),
      // "/get": (context) => MyAppg(),
    },
  ));
}
