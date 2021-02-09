class DiaryPagesInformation {
  int _id;
  String _placeName;
  String _date;
  String _explanation;

  DiaryPagesInformation(this._placeName, this._explanation, this._date);
  DiaryPagesInformation.withId(
      this._id, this._placeName, this._explanation, this._date);

  int get id => _id;
  String get placeName => _placeName;
  String get date => _date;
  String get explanation => _explanation;

  set placeName(String value) {
    if (value.length > 0) {
      _placeName = value;
    }
  }

  set explanation(String value) {
    if (value.length > 0) {
      _explanation = value;
    }
  }

  set date(String value) {
    if (value.length > 0) {
      _date = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["placeName"] = _placeName;
    map["explanation"] = _explanation;
    map["date"] = _date;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  DiaryPagesInformation.fromObject(dynamic o) {
    this._id = o["Id"];
    this._placeName = o["PlaceName"];
    this._explanation = o["Explanation"];
    this._date = o["Date"];
  }
}
