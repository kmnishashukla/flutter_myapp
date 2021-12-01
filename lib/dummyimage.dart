import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
//import 'package:image_upload_php_mysql/AllPersonData.dart';
import 'package:myapp/AllPersonData.dart';

class DemoUploadImage extends StatefulWidget {
  @override
  _DemoUploadImageState createState() => _DemoUploadImageState();
}

class _DemoUploadImageState extends State<DemoUploadImage> {
  File _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://192.168.43.128/crudop/upload.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController.text;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllPersonData(),
        ),
      );
      //print('Image Uploded');
    } else {
      print('Image Not Uploded');
    }
    setState(() {});
  }

  // String _mySelection;
  // List<Map> _myJson = [
  //   {"id": 0, "name": "<New>"},
  //   {"id": 1, "name": "Test Practice"}
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                choiceImage();
              },
            ),
            Container(
              child: _image == null
                  ? Text('No Image Selected')
                  : Image.file(_image),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Upload Image'),
              onPressed: () {
                uploadImage();
              },
            ),
            // Center(
            //   child: new DropdownButton(
            //     isDense: true,
            //     hint: new Text("Select"),
            //     value: _mySelection,
            //     onChanged: (newValue) {
            //       setState(() {
            //         _mySelection = newValue;
            //       });

            //       print(_mySelection);
            //     },
            //     items: _myJson.map((Map map) {
            //       return new DropdownMenuItem(
            //         value: map["id"].toString(),
            //         child: new Text(
            //           map["name"],
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
