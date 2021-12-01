class User {
  String id;
  String name;
  String phone;
  String email;

  User(this.id, this.name, this.phone, this.email);

  User.map(dynamic obj) {
    this.id = obj["id"];
    this.name = obj["name"];
    this.phone = obj["phone"];
    this.email = obj["email"];
  }
  String get _id => id;
  String get _name => name;

  String get _phone => phone;

  String get _email => email;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["phone"] = phone;
    map["email"] = email;

    return map;
  }

  void setUserId(String id) {
    this.id = id;
  }
}
