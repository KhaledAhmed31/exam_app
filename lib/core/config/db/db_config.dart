import 'package:sqflite/sqflite.dart';

const String dbName = "results_history";
Database? _db;
Future<Database> get getDb async {
  if (_db != null) return _db!;
  final path = await getDatabasesPath();
  final dbPath = "$path/$dbName.db";
  _db = await openDatabase(dbPath, onCreate: _initDb, version: 1);
  return _db!;
}

Future<void> _initDb(Database db, int version) async {
  await db.execute('''
  CREATE TABLE exams (
    examId TEXT,
    examTitle TEXT,
    questions INTEGER,
    correct INTEGER,
    time INTEGER,
    finishDuration INTEGER
  );
''');

  await db.execute('''
  CREATE TABLE results (
    subjectName TEXT,
    examId TEXT,
    FOREIGN KEY (examId) REFERENCES exams(examId)
  );
''');
}
