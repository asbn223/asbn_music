import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> playlistDB() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'playlists.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_playlists(id TEXT PRIMARY KEY, playlist_name TEXT, song_id TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insertIntoPlaylistDB(
      String table, Map<String, dynamic> data) async {
    final db = await playlistDB();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await playlistDB();
    return db.query(table);
  }
}
