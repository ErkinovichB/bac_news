import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/location_user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'parentControlData.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE userList('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'latitude REAL, '
      'current_time TEXT, '
      'longitude REAL)',
    );
  }

  Future<int> saveUser(LocationUserModel data) async {
    var dbClient = await db;
    var result = await dbClient.insert(
      "userList",
      data.toJson(),
    );
    return result;
  }

  Future<List<LocationUserModel>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM userList');
    print(list);
    List<LocationUserModel> users = <LocationUserModel>[];
    for (int i = 0; i < list.length; i++) {
      LocationUserModel data = LocationUserModel(
        id: list[i]["id"],
        latitude: list[i]["latitude"],
        longitude: list[i]["longitude"],
        currentTime: list[i]["current_time"],
      );
      users.add(data);
    }
    return users;
  }
}
