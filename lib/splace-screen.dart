import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/home.dart';
import 'package:myapp/user-home.dart';
import 'package:myapp/user-session.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/login.dart';

import 'nav.dart';

class SplaceScreen extends StatefulWidget {
  @override
  _SplaceScreen createState() => _SplaceScreen();
}

class _SplaceScreen extends State<SplaceScreen> {
  SharedPreferences sharedPreferences;
  SharedPreferences pre;
  UserSession session;
  bool checkValue = false;
  startTime() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  Future getClearSession() async {
    pre = await SharedPreferences.getInstance();
    pre.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void navigationPage() {
    //  print(getstatus);

    checkValue = sharedPreferences.getBool("check");

    if (checkValue != null) {
      if (checkValue) {
        String email = sharedPreferences.getString(session.KEY_USER_EMAIL);
        print("usee sk Key" + email);
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new UserHome()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new HomePage()),
            (Route<dynamic> route) => false);
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage()),
          (Route<dynamic> route) => false);

      checkValue = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    session = new UserSession(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("Welcome")],
        ),
      ),
    );
  }
}
