import 'package:ff/models/diaryPagesInformation.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  String tblDiaryPagesInformation = "Informations";
  String colId = "Id";
  String colPlaceName = "PlaceName";
  String colExplanation = "Explanation";
  String colDate = "Date";

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "diary.db";

    var dbEtrade = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbEtrade;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "Create table $tblDiaryPagesInformation($colId integer primary key, $colPlaceName text, $colExplanation text, $colDate text)");
  }

  Future<int> insert(DiaryPagesInformation diaryPagesInformation) async {
    Database db = await this.db;
    var result = await db.insert(
        tblDiaryPagesInformation, diaryPagesInformation.toMap());
    return result;
  }

  Future<int> update(DiaryPagesInformation diaryPagesInformation) async {
    Database db = await this.db;
    var result = await db.update(
        tblDiaryPagesInformation, diaryPagesInformation.toMap(),
        where: "$colId = ?", whereArgs: [diaryPagesInformation.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db
        .rawDelete("Delete from $tblDiaryPagesInformation where $colId = $id");
    return result;
  }

  Future<List> getDiaryPagesInformation() async {
    Database db = await this.db;
    var result = await db.rawQuery("Select * from $tblDiaryPagesInformation");
    return result;
  }
}
