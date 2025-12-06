import 'package:hoora/constants/db_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDb {
  static final SqliteDb instance = SqliteDb._internal();
  static Database? _database;

  SqliteDb._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("${DbConstants.favoritesTableName}.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DbConstants.favoritesTableName} (
         ${DbConstants.atomicNumber} INTEGER PRIMARY KEY,
         ${DbConstants.isFavorite} INTEGER NOT NULL
      );
    ''');
  }

  Future<bool> toggleFavorite(int atomicNumber, bool isFavorite) async {
    final db = await database;
    try {
     final result =  await db.insert(
        DbConstants.favoritesTableName,
        {
          DbConstants.atomicNumber: atomicNumber,
          DbConstants.isFavorite: isFavorite ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
     return result > 0;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<void> removeFavorite(int atomicNumber) async {
    final db = await database;
    await db.delete(DbConstants.favoritesTableName, where: '${DbConstants.atomicNumber}= ?', whereArgs: [atomicNumber]);
  }

  Future<bool> isFavorite(int atomicNumber) async {
    final db = await database;
    final res = await db.query(
      DbConstants.favoritesTableName,
      where: '${DbConstants.atomicNumber} = ?',
      whereArgs: [atomicNumber],
      limit: 1,
    );
    return res.isNotEmpty && res.first[DbConstants.isFavorite] == 1;
  }

  Future<List<int>> getAllFavorites() async {
    final db = await database;
    final res = await db.query(DbConstants.favoritesTableName, where: '${DbConstants.isFavorite} = ?', whereArgs: [1]);
    return res.map((e) => int.parse(e[DbConstants.atomicNumber].toString())).toList();
  }


  Future close() async {
    final db = await database;
    db.close();
  }
}
