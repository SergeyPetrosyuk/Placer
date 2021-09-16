import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) => db.execute(
        'CREATE TABLE places('
        'id TEXT PRIMARY KEY,'
        'title TEXT,'
        'image TEXT'
        ')',
      ),
    );
  }

  static Future<void> insert({
    required String table,
    required Map<String, Object> data,
  }) async {
    final db = await DbHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getAll(String table) async {
    final db = await database();
    return db.query(table);
  }
}
