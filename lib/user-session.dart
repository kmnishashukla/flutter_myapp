import 'package:flutter/cupertino.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  SharedPreferences pre;
  //String KEY_SK = "skuser";//email se login

  String KEY_USER_NAME = "name";
  String KEY_USER_PHONE = "phone";
  String KEY_USER_EMAIL = "email";
  String KEY_USER_ID = "id";

  UserSession(BuildContext context);

  setCredential(String name, String email, String phone, String id) async {
    pre = await SharedPreferences.getInstance();
    pre.setBool("check", true);
    pre.setString(KEY_USER_NAME, name);
    pre.setString(KEY_USER_PHONE, phone);
    pre.setString(KEY_USER_EMAIL, email);
    pre.setString(KEY_USER_ID, id);

    pre.commit();
  }

  Future<Map> getUserData() async {
    Map<String, String> createDoc = Map();
    pre = await SharedPreferences.getInstance();

    createDoc[KEY_USER_EMAIL] = pre.getString(KEY_USER_EMAIL);
    createDoc[KEY_USER_ID] = pre.getString(KEY_USER_ID);
    createDoc[KEY_USER_NAME] = pre.getString(KEY_USER_NAME);
    createDoc[KEY_USER_PHONE] = pre.getString(KEY_USER_PHONE);

    return createDoc;
  }

  Future<List<User>> getUserStoreData() async {
    pre = await SharedPreferences.getInstance();
    List<User> employees = new List();

    var user = new User(
        pre.getString(KEY_USER_ID),
        pre.getString(KEY_USER_NAME),
        pre.getString(KEY_USER_PHONE),
        pre.getString(KEY_USER_EMAIL));
    employees.add(user);

    print("empdataslite" + employees.toString());
    return employees;
  }

  Future getClearSession() async {
    pre = await SharedPreferences.getInstance();
    pre.clear();
  }
}
