import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../domain/entities/report.dart';
import 'i_report_local_datasource.dart';

class DatabaseHelper implements IReportDataSource {
  static Database? _database;
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'reports.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reports (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        clientid INTEGER,
        usid INTEGER,
        problem TEXT,
        desc TEXT,
        rating INTEGER,
        duration TEXT,
        startDate TEXT
      )
    ''');
  }

@override
  Future<int> insertReport(Report report) async {
    Database db = await database;
    return await db.insert('reports', report.toJson());
  }

@override
  Future<List<Report>> getReports() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('reports');
    return List.generate(maps.length, (i) {
      return Report.fromJson(maps[i]);
    });
  }

@override
  Future<int> updateReport(Report report) async {
    Database db = await database;
    return await db.update(
      'reports',
      report.toJson(),
      where: 'id = ?',
      whereArgs: [report.id],
    );
  }

@override
  Future<int> deleteReport(int id) async {
    Database db = await database;
    return await db.delete(
      'reports',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
Future<int> getPendingCount() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('reports');
    var list = List.generate(maps.length, (i) {
      return Report.fromJson(maps[i]);
    });
    int count = list.length;
  return count;
}

}
