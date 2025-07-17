import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/note.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
        );
      },
    );
  }

  Future<int> insertNote(Note note) async {
    final dbClient = await db;
    return await dbClient.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final dbClient = await db;
    final maps = await dbClient.query('notes');
    return maps.map((note) => Note.fromMap(note)).toList();
  }

  Future<int> updateNote(Note note) async {
    final dbClient = await db;
    return await dbClient.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final dbClient = await db;
    return await dbClient.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
