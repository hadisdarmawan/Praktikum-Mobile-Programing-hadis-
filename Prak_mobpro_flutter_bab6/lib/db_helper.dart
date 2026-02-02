import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Soal 1: Membuat class DatabaseHelper dan inisialisasi database
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('note.db'); // Nama database: note.db
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Soal 1 (Lanjutan): Membuat tabel saat database pertama kali dibuat
  Future _createDB(Database db, int version) async {
    // Struktur tabel sesuai spesifikasi
    await db.execute('''
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      created_at TEXT
    )
    ''');
  }

  // Soal 2: Insert Data
  Future<int> create(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('notes', row);
  }

  // Soal 3: Menampilkan (Read) Data
  Future<List<Map<String, dynamic>>> readAllNotes() async {
    final db = await instance.database;
    // Mengambil seluruh data dari tabel notes
    return await db.query('notes', orderBy: 'created_at DESC');
  }

  // Soal 4: Update Data
  Future<int> update(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update(
      'notes',
      row,
      where: 'id = ?', // Pastikan hanya id tertentu yang diperbarui
      whereArgs: [id],
    );
  }

  // Soal 5: Delete Data
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
