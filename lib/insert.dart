import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
//import 'package:myapp/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InsertRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Insert Your Data';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  bool visible = false;

  Future webCall() async {
    //print("bhsbhs");
    setState(() {
      visible = true;
    });
    String name = nameController.text;
    String email = emailController.text;
    String mobile = mobileController.text;
    String password = passwordController.text;
    var url = Uri.parse('http://192.168.31.140/crud/insert.php');

    Map<String, String> dataMap = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password
    };
    var response = await http.post(url, body: dataMap);
    var data = jsonDecode(response.body);
    if (data['status'] == true) {
      setState(() {
        visible = true;
      });
      nameController.text = '';
    } else {
      setState(() {
        visible = false;
      });
    }
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: mobileController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.email),
              hintText: 'Enter a email',
              labelText: 'email',
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              icon: const Icon(Icons.lock_open),
              hintText: 'Enter a password',
              labelText: 'password',
            ),
          ),
          Center(
            child: Row(
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.only(left: 70.0, top: 20.0),
                    child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          form.currentState.save();
                          webCall();
                        },
                        color: Colors.green)),
                new Container(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: new RaisedButton(
                        child: const Text('Get'),
                        onPressed: () {},
                        color: Colors.green)),
                new Container(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: new RaisedButton(
                      child: const Text('Back'),
                      onPressed: () {},
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
