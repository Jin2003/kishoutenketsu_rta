import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  Database? _db;

  Future<Database> get db async {
    _db ??= await initializeDatabase();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mydatabase.db");
    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onOpen: _onOpen);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS user (point INTEGER, selected_item_id INTEGER)');
    //timesテーブルがなければ作成
    await db.execute(
        'CREATE TABLE IF NOT EXISTS times (time_id INTEGER PRIMARY KEY AUTOINCREMENT, time_record INTEGER, time_datetime TEXT)');
    //itemsテーブルがなければ作成
    await db.execute(
        'CREATE TABLE IF NOT EXISTS items (item_id INTEGER, item_name TEXT, item_file_name TEXT, has_Item INTEGER)');
    //NFCテーブルがなければ作成
    await db.execute('CREATE TABLE IF NOT EXISTS nfc (nfc_id INTEGER)');
  }

  Future<void> _onOpen(Database db) async {
    //[デバッグ用]テーブルを削除
    await db.execute('DROP TABLE user');
    await db.execute('DROP TABLE times');
    await db.execute('DROP TABLE items');
    await db.execute('DROP TABLE nfc');

    //userテーブルがなければ作成
    await db.execute(
        'CREATE TABLE IF NOT EXISTS user (point INTEGER, selected_item_id INTEGER)');
    //timesテーブルがなければ作成
    await db.execute(
        'CREATE TABLE IF NOT EXISTS times (time_id INTEGER PRIMARY KEY AUTOINCREMENT, time_record INTEGER, time_datetime TEXT)');
    //itemsテーブルがなければ作成
    await db.execute(
        'CREATE TABLE IF NOT EXISTS items (item_id INTEGER, item_name TEXT, item_file_name TEXT, has_Item INTEGER)');
    //NFCテーブルがなければ作成
    await db.execute('CREATE TABLE IF NOT EXISTS nfc (nfc_id INTEGER)');
    //userテーブルの行数を取得
    var count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user'));
    //userテーブルを初期化
    if (count == 0) {
      await db.execute(
          'INSERT INTO user (point, selected_item_id) VALUES (?, ?)', [100, 0]);
    }

    var count1 =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM times'));
    if (count1 == 0) {
      await db.execute(
          'INSERT INTO times (time_record, time_datetime) VALUES (?, ?)',
          [123, '23.04/25']);
      await db.execute(
          'INSERT INTO times (time_record, time_datetime) VALUES (?, ?), (?, ?), (?, ?), (?, ?), (?, ?), (?, ?), (?, ?), (?, ?)',
          [
            51,
            '23.04/22',
            58,
            '23.04/12',
            44,
            '23.04/23',
            60,
            '23.04/18',
            130,
            '23.04/26',
            120,
            '23.04/27',
            69,
            '23.04/28',
            71,
            '23.04/16',
          ]);
    }
    //デバッグ用のデータを挿入
    //timesテーブルを初期化
  }

  // Future<void> _onCreate(Database db, int version) async {
  //   //userテーブルがなければ作成
  //   await db.execute(
  //       'CREATE TABLE IF NOT EXISTS user (point INTEGER, selected_item_id INTEGER)');
  //   //timesテーブルがなければ作成
  //   await db.execute(
  //       'CREATE TABLE IF NOT EXISTS times (time_record INTEGER, time_datetime TEXT)');
  //   //userテーブルの行数を取得
  //   var count =
  //       Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user'));
  //   //userテーブルを初期化
  //   if (count == 0) {
  //     await db.execute(
  //         'INSERT INTO user (point, selected_item_id) VALUES (?, ?)', [0, 0]);
  //   }
  // }

  // Future<void> _onOpen(Database db) async {}
}
