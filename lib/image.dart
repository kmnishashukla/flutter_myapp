import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:myapp/user-session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String userid = "";
  UserSession session;
  Future getData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      userid = pre.getString("Id");
      // print(userid);
    });
  }

  File _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  String msg = '';
  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://kolocon.in/api/image.php");
    //print("hii");
    var request = http.MultipartRequest('POST', uri);
    //request.fields['name'] = nameController.text;
    request.fields['Id'] = userid;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      Flushbar(
          message: "Image uploeded",
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.red)
        ..show(context);
    } else {
      Flushbar(
          message: "image not uploaded",
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.red)
        ..show(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    session = new UserSession(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Photo"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Padding(
              // padding: const EdgeInsets.all(8.0),
              // child: //TextField(
              // controller: nameController,
              //decoration: InputDecoration(labelText: 'Name'),
              //),
              // ),
              IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    choiceImage();
                  }),
              Container(
                child: _image == null
                    ? Text("no image selected")
                    : Image.file(_image),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text('image upload'),
                onPressed: () {
                  uploadImage();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
