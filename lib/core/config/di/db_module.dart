import 'package:exam_app/core/config/db/db_config.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class DbModule {
  @preResolve
  Future<Database> get initDb async {
    return await getDb;
  }
}