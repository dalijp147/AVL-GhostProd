import 'package:map/Models/location.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'cart.dart';

class DB {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'location.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

// creating database table
  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE location(id INTEGER PRIMARY  KEY AUTOINCREMENT  , longitude VARCHAR , latitude VARCHAR)',
    );
  }

// inserting data into the table
  Future<LocationP> insert(LocationP location) async {
    var dbClient = await database;
    await dbClient!.delete('location');
    await dbClient.insert(
      'location',
      location.toMap(),
    );
    return location;
  }

  Future<List<Map<String, dynamic>>> getDatalocation() async {
    var dbClient = await database;
    final List<Map<String, dynamic>> maps =
        await dbClient!.rawQuery("SELECT * FROM location");
    return maps;
  }
}
