import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDb() async {
  var dbName = 'data.db';
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, dbName);
  // deleteDatabase(path);

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute('''
          CREATE TABLE "events" (
            "id" INTEGER PRIMARY KEY,
            "description" TEXT NOT NULL,
            "time" TIMESTAMPTZ NOT NULL
          );
        ''');
    },
  );
}
