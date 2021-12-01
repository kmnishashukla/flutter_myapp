//import 'dart:html';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/about.dart';
import 'package:myapp/contact.dart';
import 'package:myapp/crud.dart';
import 'package:myapp/dummyimage.dart';
import 'package:myapp/image.dart';
import 'package:myapp/photo.dart';
import 'package:myapp/CommentPage.dart';
import 'package:myapp/user-session.dart';
import 'package:myapp/ForMap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  String userName = "";
  UserSession session;
  Future getData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      userName = pre.getString("name");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  int pageIndex = 0;
  final AboutPage _AboutPage = AboutPage();
  final PhotoPage _PhotoPage = PhotoPage();
  final ContactPage _ContactPage = ContactPage();
  final CommentPage _CommentPage = CommentPage();
  final ForMapage _ForMapage = ForMapage();
  // final PhotoPage _PhotoPage = PhotoPage();
  Widget _showPage = new AboutPage();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _AboutPage;
        break;
      case 1:
        return _ContactPage;
        break;
      case 2:
        return _PhotoPage;
        break;
    }
  }

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    session = new UserSession(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Welcome To Kolonizer",
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              session.getClearSession();
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: pageIndex,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(Icons.collections_outlined, size: 30),
          Icon(Icons.contact_mail_sharp, size: 30),
          Icon(Icons.comment_outlined, size: 30),
          Icon(Icons.location_on, size: 30),
        ],
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
    );
  }
}

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String userName = "";
  UserSession session;
  Future getData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      userName = pre.getString("name");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blueAccent,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/photo.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Center(
                  //   child: CircleAvatar(
                  //     radius: 50,
                  //     backgroundImage: NetworkHandler().getImage(""),
                  //      ,
                  //   ),
                  // ),
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.camera),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () {
                        //choiceImage();
                      },
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'My Account',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImagePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text(
              'Product',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyAppm()));
            },
          ),
          ListTile(
            leading: Icon(Icons.collections_outlined),
            title: Text(
              'Image',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DemoUploadImage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Setting',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
