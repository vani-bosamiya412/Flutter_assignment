import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // Database Details
  static final _dbName = "todo.db";
  static final _dbVersion = 1;

  // Table Details
  static final tableTask = "tasks";
  static final columnId = "id";
  static final columnTitle = "title";
  static final columnDescription = "description";
  static final columnStatus = "status";

  // Private Constructor
  DBHelper._privateConstructor();

  // Instance
  static final DBHelper instance = DBHelper._privateConstructor();

  Database? db;

  // Get Database
  Future<Database> get database async => db ??= await _initDatabase();

  // Initialize Database
  _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate,);
  }

  // Create Table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableTask (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT,
        $columnStatus INTEGER NOT NULL
      )
    ''');
  }

  // Insert Task
  Future<int> insertTask(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableTask, row);
  }

  // Get all tasks
  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database db = await instance.database;
    return await db.query(tableTask, orderBy: "$columnId DESC");
  }

  // Update task
  Future<int> updateTask(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(tableTask, row, where: "$columnId = ?", whereArgs: [id]);
  }

  // Delete task
  Future<int> deleteTask(int id) async {
    Database db = await instance.database;
    return await db.delete(tableTask, where: "$columnId = ?", whereArgs: [id]);
  }
}