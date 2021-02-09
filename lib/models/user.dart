class User {
  int _id;
  String _email;
  String _password;

  User(this._email, this._password);
  User.withId(this._id, this._email, this._password);

  int get id => _id;
  String get email => _email;
  String get password => _password;

  set email(String value) {
    if (value.length > 0) {
      _email = value;
    }
  }

  set password(String value) {
    if (value.length > 0) {
      _password = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["email"] = _email;
    map["password"] = _password;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  User.fromObject(dynamic o) {
    this._id = o["Id"];
    this._email = o["Email"];
    this._password = o["Password"];
  }
}
