import 'package:fast2mine_challenge/features/home_page/data/models/ciclo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper databaseInstance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Simulacao.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(Ciclo.createTable);
  }

  Future<bool> insert(
    String table,
    Map<String, Object?> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    final db = await databaseInstance.database;
    await db.insert(table, values);
    return true;
  }

  Future<List<Map<String, Object?>>> getAllWhere(
      String table, String where) async {
    final db = await databaseInstance.database;
    final result = await db.query(
      table,
      where: where,
    );
    return result;
  }

  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await databaseInstance.database;
    return db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await databaseInstance.database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<Map<String, Object?>>> rawQuery(String query) async {
    final db = await databaseInstance.database;
    final response = await db.rawQuery(query);
    return response;
  }

  Future close() async {
    final db = await databaseInstance.database;
    db.close();
  }
}
