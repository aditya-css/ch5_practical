import 'package:ch5_practical/core/db_const.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class LocalDatabaseProvider {
  LocalDatabaseProvider._();

  static final LocalDatabaseProvider dbProvider = LocalDatabaseProvider._();

  Database? _database;

  Future<Database> get dBase async {
    _database ??= await getDatabaseInstance();
    return _database!;
  }

  Future<Database> getDatabaseInstance() async {
    String dir = await getDatabasesPath();
    String path = join(dir, DBConst.dbName);
    return await openDatabase(path,
        version: DBConst.dbVersion, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE ${DBConst.tableName} ("
      "${DBConst.colId} INTEGER PRIMARY KEY AUTOINCREMENT,"
      "${DBConst.colAuthor} TEXT,"
      "${DBConst.colTitle} TEXT,"
      "${DBConst.colDesc} TEXT,"
      "${DBConst.colBody} TEXT,"
      "${DBConst.colImg} TEXT,"
      "${DBConst.colDate} TEXT"
      ")",
    );
  }
}
