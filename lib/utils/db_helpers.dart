import 'package:path/path.dart';
import 'package:sampling/models/yesema_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tesebaki_model.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;
  DBHelper._createInstance();

  final String tableName = "tesebakis";
  final String cId = 'id';
  final String cName = 'name';
  final String cPhone = 'phone';
  final String cType = 'type';
  final String cGender = 'gender';
  final String cSebakiId = 'sebaki_id';
  final String cCampusId = 'campus_id';
  final String cDate = 'date';
  final String cIsSent = 'is_sent';

  final String table2Name = "yesemus";
  final String cNumber = "number";

  get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }

    return _dbHelper;
  }

  Future<Database> initializeDatabase() async {
    var path = join(await getDatabasesPath(), 'tesebaki.db');

    var db = await openDatabase(path, version: 1, onCreate: createDB);
    return db;
  }

  createDB(Database db, int version) async {
    String sql = "CREATE TABLE $tableName (";
    sql += "$cId INTEGER PRIMARY KEY autoincrement,";
    sql += "$cName TEXT,";
    sql += "$cPhone TEXT,";
    sql += "$cType TEXT,";
    sql += "$cGender TEXT,";
    sql += "$cSebakiId INTEGER,";
    sql += "$cCampusId INTEGER,";
    sql += "$cIsSent INTEGER,";
    sql += "$cDate TEXT)";

    String sql2 = "CREATE TABLE $table2Name (";
    sql2 += "$cId INTEGER PRIMARY KEY autoincrement,";
    sql2 += "$cNumber INTEGER,";
    sql2 += "$cSebakiId INTEGER,";
    sql2 += "$cCampusId INTEGER,";
    sql2 += "$cIsSent INTEGER,";
    sql2 += "$cDate TEXT)";
    await db.execute(sql);
    await db.execute(sql2);
  }

  //fetch all maps
  Future<List<Map>> getTesebakis() async {
    Database db = await database;
    var query = await db.query(tableName, orderBy: '$cDate DESC');

    return query;
  }

  Future<List<Tesebaki>> getSentTesebakisList() async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query(tableName,
        where: '$cIsSent = ?', whereArgs: [1], orderBy: '$cDate DESC');

    List<Tesebaki> tesebakiList = List<Tesebaki>();

    for (var map in mapList) {
      var tesebaki = Tesebaki.toObject(map);
      tesebakiList.add(tesebaki);
    }

    return tesebakiList;
  }

  //un sent

  Future<List<Tesebaki>> getUnSentTesebakisList() async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query(tableName,
        where: '$cIsSent = ?', whereArgs: [0], orderBy: '$cDate DESC');

    List<Tesebaki> tesebakiList = List<Tesebaki>();

    for (var map in mapList) {
      var tesebaki = Tesebaki.toObject(map);
      tesebakiList.add(tesebaki);
    }
    return tesebakiList;
  }

  Future<List<Yesema>> getUnsentYesemuList() async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query(table2Name,
        where: '$cIsSent = ?', whereArgs: [0], orderBy: '$cDate DESC');

    List<Yesema> yesemu = List<Yesema>();

    for (var map in mapList) {
      var yesema = Yesema.toObject(map);
      yesemu.add(yesema);
    }
    return yesemu;
  }

  //insert all
  Future<int> insertTesebaki(Tesebaki tesebaki) async {
    Database db = await database;

    int result = await db.insert(tableName, tesebaki.toJson());

    return result;
  }

  Future<int> insertYesema(Yesema yesema) async {
    Database db = await database;

    int result = await db.insert(table2Name, yesema.toJson());

    return result;
  }

  //update
  updateTesebaki(Tesebaki tesebaki) async {
    var db = await database;

    print("Tesebaki id : ${tesebaki.id}");
    var result = await db.update(tableName, tesebaki.toJson(),
        where: 'id = ?', whereArgs: [tesebaki.id]);

    return result;
  }

  //change Status

  updateStatus(Tesebaki tesebaki) async {
    Database db = await database;

    var result = await db.update(tableName, tesebaki.toJson(),
        where: 'id = ?', whereArgs: [tesebaki.id]);

    return result;
  }

  updateYesemaStatus(Yesema yesema) async {
    Database db = await database;

    var result = await db.update(tableName, yesema.toJson(),
        where: 'id = ?', whereArgs: [yesema.id]);

    return result;
  }
  //delete

  Future<int> deleteTesebaki(int id) async {
    var db = await database;
    var result = await db.delete(tableName, where: '$cId = ?', whereArgs: [id]);

    return result;
  }

  Future<int> removeAllYesemu() async {
    var db = await database;
    var result = await db.delete(tableName);

    return result;
  }

  //getTesebakiList

  Future<List<Tesebaki>> getTesebakiList() async {
    List<Map> mapList = await this.getTesebakis();

    List<Tesebaki> tesebakiList = List<Tesebaki>();

    for (var map in mapList) {
      var tesebaki = Tesebaki.toObject(map);
      tesebakiList.add(tesebaki);
    }

    return tesebakiList;
  }
}
