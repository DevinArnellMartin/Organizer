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
