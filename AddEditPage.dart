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
    } else {
      var url = Uri.parse('http://kolocon.in/api/add.php');
      //var url = 'http://192.168.31.140/crudop/add.php';
      http.post(url, body: {
        'name': name.text,
        'mobile': mobile.text,
        'email': email.text,
        'password': password.text,
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Data'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: mobile,
              decoration: InputDecoration(
                labelText: 'Mobile',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  addUpdateData();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.blue,
              child: Text(
                editMode ? 'Update' : 'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
