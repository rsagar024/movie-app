import 'dart:io';

import 'package:movie_app/core/models/notification_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDatabaseMethods {
  static NotificationDatabaseMethods? _notificationDatabaseMethods;
  static Database? _notifyDatabase;

  String notifyDb = 'notify_db';
  NotificationDatabaseMethods._createInstance();

  factory NotificationDatabaseMethods() {
    _notificationDatabaseMethods ??=
        NotificationDatabaseMethods._createInstance();
    return _notificationDatabaseMethods!;
  }

  /// Notification Database
  Future<Database> get notifyDatabase async {
    _notifyDatabase ??= await initializeNotifyDatabase();
    return _notifyDatabase!;
  }

  initializeNotifyDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}notify.db';

    //Open/Create the database at a given path
    var notifyDb =
        await openDatabase(path, version: 1, onCreate: _createNotifyDb);
    return notifyDb;
  }

  void _createNotifyDb(Database db, int newVersion) async {
    const notifyTableSql = '''
      CREATE TABLE notify_db (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        body TEXT,
        date TEXT,
        payload TEXT,
        click INTEGER
      )
    ''';
    await db.execute(notifyTableSql);
  }

  /// CRUD operations in notify_db table

  Future<int> insertNotify(NotificationModel notify) async {
    Database db = await notifyDatabase;
    int result = await db.insert(notifyDb, notify.toMap());
    return result;
  }

  Future<int> updateNotify(NotificationModel notify) async {
    Database db = await notifyDatabase;
    int result = await db.update(notifyDb, {'click': notify.click}, where: 'id = ${notify.id}');
    return result;
  }

  Future<int> deleteNotify(String id) async {
    Database db = await notifyDatabase;
    int result = await db.delete(notifyDb, where: 'id = $id');
    return result;
  }

  Future<List<Map<String, dynamic>>> getNotifyMapList() async {
    Database db = await notifyDatabase;
    var result = await db.query(notifyDb);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Notification List' [ List<NotificationModel> ]
  Future<List<NotificationModel>> getNotifyList() async {
    var notifyMapList =
        await getNotifyMapList(); // Get 'Map List' from database

    List<NotificationModel> notifyList = <NotificationModel>[];
    for (int i = notifyMapList.length - 1; i >= 0; i--) {
      notifyList.add(NotificationModel.fromMap(notifyMapList[i]));
    }
    return notifyList;
  }

  // Get number of Movie objects in database
  Future<int> getNotifyCount() async {
    Database db = await notifyDatabase;
    List<Map<String, dynamic>> notifies =
        await db.rawQuery('SELECT COUNT (*) FROM $notifyDb');
    int result = Sqflite.firstIntValue(notifies) ?? 0;
    return result;
  }
}
