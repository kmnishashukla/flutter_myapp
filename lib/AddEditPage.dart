import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/crud.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  AddEditPage({this.list, this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = Uri.parse('http://kolocon.in/api/edit.php');
      // var url = 'http://192.168.31.140/crudop/edit.php';
      http.post(url, body: {
        'id': widget.list[widget.index]['Id'],
        'name': name.text,
        'mobile': mobile.text,
        'email': email.text,
        'password': password.text,
      });
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePag(),
        ),
      );
    } else {
      var url = Uri.parse('http://kolocon.in/api/add.php');
      //var url = 'http://192.168.31.140/crudop/add.php';
      http.post(url, body: {
        'name': name.text,
        'mobile': mobile.text,
        'email': email.text,
        'password': password.text,
      });
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePag(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      name.text = widget.list[widget.index]['name'];
      mobile.text = widget.list[widget.index]['mobile'];
      email.text = widget.list[widget.index]['email'];
      password.text = widget.list[widget.index]['password'];
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(editMode ? 'Update Your Data' : 'Add Your Data'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    //labelText: 'Enter Your Name',
                    hintText: 'Enter Your Name'),
                keyboardType: TextInputType.text,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.length < 2) {
                    return 'Password should have atleast 2 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: mobile,
                decoration:
                    InputDecoration(hintText: 'Enter Your Mobile number'),
                keyboardType: TextInputType.phone,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }

                  if (value.length != 10) {
                    return 'A valid phone number should be of 10 digits';
                  }
                },
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(hintText: 'Enter Your Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Your Email';
                  }
                  if (!value.contains('@')) {
                    return "A valid email should contain '@'";
                  }
                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                },
                // The validator receives the text that the user has entered.
                //validator: (value) {
                //if (value == null ||
                // value.isEmpty ||
                // !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //   .hasMatch(value)) {
                // return 'Please enter your valid email';
                //}
                //if (value.isEmpty) {
                // return 'This field is required';
                // }
                //if (!value.contains('@')) {
                //  return "A valid email address should contain '@'";
                //  }
                //return null;
                // },
              ),
              TextField(
                controller: password,
                obscureText: _isObscure,
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        })),
                keyboardType: TextInputType.visiblePassword,

                //validator: (value) {
                // if (value.isEmpty) {
                // return 'This field is required';
                // }
                //if (value.length < 8) {
                // return 'Password should have atleast 8 characters';
                // }
                //if (!RegExp(r'[A-Z0-9a-z]*').hasMatch(value)) {
                //return 'Enter a stronger password';
                // }
                //},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a data

                      setState(() {
                        addUpdateData();
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
