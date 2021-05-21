import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const CREATE_TABLE_PLACES = """
    CREATE TABLE user_places(
      id TEXT PRIMARY KEY,
      title TEXT,
      image TEXT
    );
  """;

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return await db.query(table);
  }

  static Future<Database> database() async =>
      _openDatabase(await _getDatabaseFile('places.db'));

  static Future<String> _getDatabaseFile(String name) async {
    return path.join(await sql.getDatabasesPath(), name);
  }

  static Future<Database> _openDatabase(String database) async {
    return sql.openDatabase(
      database,
      onCreate: (db, version) {
        db.execute(CREATE_TABLE_PLACES);
      },
      version: 1,
    );
  }
}
