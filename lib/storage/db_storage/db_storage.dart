import 'dart:async';

import 'package:first_station/storage/db_storage/dao/merit_record_dao.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class Dbstorage {
  //私有化构建
  Dbstorage._();

  static Dbstorage? _storage;

  //提供实例对象的访问途径
  static Dbstorage get instance {
    _storage = _storage ?? Dbstorage._();
    return _storage!;
  }

  late Database _db;
  late MeritRecordDao _meritRecordDao;

  MeritRecordDao get meritRecordDao => _meritRecordDao;

  //打开数据库
  Future<void> open() async {
    //获取数据库路径
    String databasesPath = await getDatabasesPath();
    //构建数据库文件的完整路径
    String dbPath = path.join(databasesPath, 'first_station.db');

    //打开数据库
    _db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    _meritRecordDao = MeritRecordDao(_db);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await MeritRecordDao.createTable(db);
  }
}
