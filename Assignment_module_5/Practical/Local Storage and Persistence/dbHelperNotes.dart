import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperNotes {
  static final _dbName = "notes.db";
  static final _dbVersion = 1;

  static final table = "notes";
  static final columnId = "id";
  static final columnTitle = "title";
  static final columnContent = "content";

  DBHelperNotes._privateConstructor();
  static final DBHelperNotes instance = DBHelperNotes._privateConstructor();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnContent TEXT
      )
    ''');
  }

  Future<int> insertNote(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    Database db = await instance.database;
    return await db.query(table, orderBy: "$columnId DESC");
  }

  Future<int> updateNote(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: "$columnId = ?", whereArgs: [id]);
  }
}