import 'dart:io';

import 'package:ff/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbUser {
  String tblUser = "Users";
  String colId = "Id";
  String colEmail = "Email";
  String colPassword = "Password";
  static final DbUser _dbUser = DbUser._internal();

  DbUser._internal();

  factory DbUser() {
    return _dbUser;
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
    String path = directory.path + "user.db";

    var dbEtrade = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbEtrade;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "Create table $tblUser($colId integer primary key, $colEmail text, $colPassword text)");
  }

  Future<int> insert(User user) async {
    Database db = await this.db;
    var result = await db.insert(tblUser, user.toMap());
    return result;
  }

  Future<int> update(User user) async {
    Database db = await this.db;
    var result = await db.update(tblUser, user.toMap(),
        where: "$colId = ?", whereArgs: [user.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("Delete from $tblUser where $colId = $id");
    return result;
  }

  Future<List> getUser() async {
    Database db = await this.db;
    var result = await db.rawQuery("Select * from $tblUser");
    return result;
  }

  Future<bool> chkEmail(String email) async {
    bool flag = false;
    List<Map<String, dynamic>> chk;
    Database db = await this.db;
    chk = await db.rawQuery("Select * from $tblUser where $colEmail='$email' ");
    if (chk.length > 0) {
      flag = true;
    }
    return flag;
  }

  Future<bool> emailPassword(String email, String password) async {
    bool flag = false;
    List<Map<String, dynamic>> chk;
    Database db = await this.db;
    chk = await db.rawQuery(
        "Select * from $tblUser where $colEmail='$email' and $colPassword='$password'");
    if (chk.length > 0) {
      flag = true;
    }
    return flag;
  }
}
