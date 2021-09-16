import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static Future<void> insert({
    required String table,
    required Map<String, Object> data,
  }) async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
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

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
