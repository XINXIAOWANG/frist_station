import 'package:first_station/models/meritRecord.dart';
import 'package:sqflite/sqflite.dart';

class MeritRecordDao {
  //在其构造函数中传入Database对象,以便在方法中操作数据库'
  final Database database;

  MeritRecordDao(this.database);

  static String tableName = 'merit_record';
  static String tableSql = """
CREATE TABLE $tableName (
id VARCHAR(64) PRIMARY KEY,
value INTEGER, 
image TEXT,
audio TEXT,
timestamp INTEGER
)""";

  static Future<void> createTable(Database db) async {
    return db.execute(tableSql);
  }

  //insert方法插入记录数据, query方法读取记录列表
  Future<int> insert(MeritRecord record) {
    return database.insert(tableName, record.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MeritRecord>> query() async {
    List<Map<String, Object?>> data = await database.query(tableName);
    return data
        .map((e) => MeritRecord(e['id'].toString(), e['timestamp'] as int,
            e['value'] as int, e['image'].toString(), e['audio'].toString()))
        .toList();
  }
}
