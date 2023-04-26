import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'favorite.dart';

class DBFavorite {
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
    String path = join(directory.path, 'favorite.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

// creating database table
  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE favorite(id INTEGER PRIMARY KEY, productName TEXT,productPrice INTEGER, image TEXT)',
    );
  }

// inserting data into the table
  Future<Favorite> insert(Favorite fav) async {
    var dbClient = await database;
    await dbClient!.insert(
      'favorite',
      fav.toMap(),
    );
    return fav;
  }

// getting all the items in the list from the database
  Future<List<Favorite>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('favorite');
    return queryResult.map((result) => Favorite.fromMap(result)).toList();
  }

// deleting an item from the cart screen
  Future<int> deleteItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('favorite', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var dbClient = await database;
    final List<Map<String, dynamic>> maps =
        await dbClient!.rawQuery("SELECT * FROM favorite");
    return maps;
  }
}
