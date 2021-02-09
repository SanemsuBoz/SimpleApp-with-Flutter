class Photo {
  String _photoName;
  int _id;

  Photo(this._photoName);
  Photo.withId(this._id, this._photoName);

  int get id => _id;
  String get photoName => _photoName;

  set photoname(String value) {
    if (value.length > 0) {
      _photoName = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["photoName"] = _photoName;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Photo.fromObject(dynamic o) {
    this._id = o["Id"];
    this._photoName = o["PhotoName"];
  }
}
