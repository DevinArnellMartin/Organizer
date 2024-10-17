import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await init();
    return _database!;
  }

  Future<Database> init() async {
    String path = join(await getDatabasesPath(), 'card_organizer.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Folders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            folder_name TEXT NOT NULL,
            timestamp TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE Cards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            suit TEXT NOT NULL,
            imgUrl TEXT,
            folder_id INTEGER,
            FOREIGN KEY (folder_id) REFERENCES Folders(id) ON DELETE CASCADE
          )
        ''');
      },
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> deleteFolderWithCards(int folderId) async {
    final db = await instance.database;
    await db.transaction((txn) async {
      
      await txn.delete(
        'Cards',
        where: 'folder_id = ?',
        whereArgs: [folderId],
      );
      await txn.delete(
        'Folders',
        where: 'id = ?',
        whereArgs: [folderId],
      );
    });
  }

  Future<List<Map<String, dynamic>>> getAllFolders() async {
    final db = await instance.database;
    return await db.query('Folders');
  }
}
