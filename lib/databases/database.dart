import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sms/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  MyDatabase._privateConstructor();

  static final MyDatabase instance = MyDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "sms.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE User(
          id INTEGER PRIMARY KEY,
          pseudo varchar(255) NOT NULL,
          email varchar(255) NOT NULL,
          onLine boolean DEFAULT 0,
          image varchar(255) NOT NULL
        );
      ''');
  }

  Future<User?> getCurrentUser() async {
    Database db = await instance.database;
    var listes = await db.query(
      "User",
      limit: 1,
    );
    if (listes.isEmpty) {
      return null;
    }
    User user = User.fromMap(listes[0]);

    return user;
  }
}
