import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/home.dart';
import 'package:myapp/splace-screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:myapp/user-session.dart';
//import 'package:fluttertoast/fluttertoast.dart';

/*class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            //padding: EdgeInsets.symmetric(horizontal: 40 ),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      makeInput(label: "Email"),
                      makeInput(
                        label: "Password",
                        obscureText: true,
                      ),
                      //makeInput(label: "Confirm Password", obscureText: true),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    //padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.red),
                          top: BorderSide(color: Colors.red),
                          left: BorderSide(color: Colors.red),
                          right: BorderSide(color: Colors.red),
                        )),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {},
                      color: Colors.blueAccent[100],
                      elevation: 0,
                      //color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account"),
                    Text(
                      "Sign Up",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
        ),
        //SizedBox(
        //height: 30,
        //),
      ],
    );
  }
}*/
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePag(),
      theme: ThemeData(
        accentColor: Colors.yellow,
      ),
    );
  }
}

class HomePag extends StatefulWidget {
  @override
  _HomePagState createState() => _HomePagState();
}

class _HomePagState extends State<HomePag> {
  UserSession userSession;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String msg = '';
  Future<List> login() async {
    final response =
        await http.post(Uri.parse("http://kolocon.in/api/login.php"), body: {
      "email": email.text,
      "password": password.text,
    });
    var datauser = json.decode(response.body);
    if (datauser['status'] == true) {
      userSession.setCredential(
          datauser['data'][0]['name'],
          datauser['data'][0]['email'],
          datauser['data'][0]['phone'],
          datauser['data'][0]['id']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplaceScreen(),
        ),
      );

      //setState(() {});
    } else {
      Flushbar(
          message: datauser['message'],
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.red)
        ..show(context);
      //print('msg = "valid"');
    }
    //print(response.body);
  }

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // Navigator.push(
  // context,
  // MaterialPageRoute(
  //  builder: (context) => MyHomePag(),
  // ),
  // );

  @override
  Widget build(BuildContext context) {
    userSession = new UserSession(context);
    return Scaffold(
      appBar: AppBar(
        //title: Text("Login to your account"),
        //leading: Icon(Icons.filter_vintage),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Login to your account",
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      //obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400])),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400])),
                      ),
                      //decoration: InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400])),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400])),
                      ),
                      //decoration: InputDecoration(hintText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (value) {},
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a data

                        setState(() {
                          login();
                        });
                      }
                    },
                    //onPressed: () {},
                    color: Colors.blueGrey[200],
                    //color: Colors.blueAccent[200],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Submit",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Text(
                    msg,
                    style: TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
