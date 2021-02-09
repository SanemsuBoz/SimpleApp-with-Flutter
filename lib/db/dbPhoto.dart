import 'dart:async';
import 'dart:io';
import 'package:ff/models/photo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbPhoto {
  String tblPhoto = "PhotosTable";
  String colId = "Id";
  String colPhotoName = "PhotoName";
  static Database _db;

  static final DbPhoto _dbPhoto = DbPhoto._internal();

  DbPhoto._internal();

  factory DbPhoto() {
    return _dbPhoto;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "photo.db";

    var dbEtrade = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbEtrade;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "Create table $tblPhoto($colId integer primary key, $colPhotoName text)");
  }

  Future<int> insert(Photo photo) async {
    Database db = await this.db;
    var result = await db.insert(tblPhoto, photo.toMap());
    return result;
  }

  Future<List<Photo>> getPhotos() async {
    Database db = await this.db;
    List<Map> maps = await db.query(tblPhoto, columns: [colId, colPhotoName]);
    List<Photo> photos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(Photo.fromObject(maps[i]));
      }
    }
    return photos;
  }

  Future close() async {
    Database db = await this.db;
    db.close();
  }
}
