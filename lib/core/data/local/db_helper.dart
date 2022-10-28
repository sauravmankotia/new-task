import 'dart:async';
import 'dart:io';

import 'package:mentomindtask/core/data/local/db_constants.dart';
import 'package:mentomindtask/core/data/local/db_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class _DbImplements{
  Future<Database> get database;
  _initiateDatabase();
  Future<void> _onCreate(Database db, int version) ;
  Future<int> saveDataToDb(DbModel model);
  Future<List<DbModel>> getDataList() ;
}

class DatabaseHelper implements _DbImplements{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance
  = DatabaseHelper._privateConstructor();

  static Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initiateDatabase();
    return _database!;
  }

  @override
  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DbConstants.DB_NAME);
    return await openDatabase(path, version: DbConstants.DB_VERSION, onCreate: _onCreate);
  }

  @override
  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE ${DbConstants.TABLE_NAME}(
       id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL
      )
      ''');
  }
  @override
  Future<int> saveDataToDb(DbModel model) async {
    Database db = await instance.database;
    return await db.insert(DbConstants.TABLE_NAME, model.toMap());
  }
  @override
  Future<List<DbModel>> getDataList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(DbConstants.TABLE_NAME);
    return List.generate(
      maps.length,
          (index) {
        return DbModel(
          id: maps[index]["id"],
          title: maps[index]["title"],
          dateTimeCreated: maps[index]["dateTimeCreated"],
        );
      },
    );
  }
}