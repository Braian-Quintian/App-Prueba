import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;

    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my_database.db');

    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        password TEXT,
        repeat_password TEXT
      )
      ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database? dbClient = await db;
    int insertedRowId = await dbClient!.insert('users', user);
    print(user);
    print('Usuario registrado con ID: $insertedRowId'); // Imprime el mensaje en la consola
    return insertedRowId;
  }
}