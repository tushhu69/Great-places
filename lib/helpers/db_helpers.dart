import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelpers {
  static Future<sql.Database> database() async {
    final dbPath =
        await sql.getDatabasesPath(); //gets the default database location
    return sql.openDatabase(path.join(dbPath, 'user_places.db'),
        onCreate: (database, version) {
      database.execute(//here REAL is a DOUBLE for sqlite
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT, image TEXT,loc_lat REAL,loc_lng REAL,address TEXT)');
    },
        version:
            1); //here we need to provide a 'path + the name of the file',because getdatabase() only returns the pasth of the folder
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelpers
        .database(); //here we have to use class name dbhelpers because the functions are static,if we will not use class name then flutter will search for global function

    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object>>> getdata(String table) async {
    final db = await DBHelpers.database();
    return db.query(table);
  }
}
