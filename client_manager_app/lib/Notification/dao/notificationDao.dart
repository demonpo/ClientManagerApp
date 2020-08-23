import 'dart:async';

import 'package:clientmanagerapp/Notification/model/Notification.dart';
import 'package:clientmanagerapp/database/databaseProvider.dart';

final NOTIFICATIONTABLE = 'Notification';

class NotificationDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createNotification(Notification notification) async {
    final db = await dbProvider.database;
    var result = db.insert(NOTIFICATIONTABLE, notification.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Notification>> getNotifications({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(NOTIFICATIONTABLE,
            columns: columns,
            where: 'name LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(NOTIFICATIONTABLE, columns: columns);
    }

    List<Notification> notifications = result.isNotEmpty
        ? result.map((item) => Notification.fromDatabaseJson(item)).toList()
        : [];
    return notifications;
  }


  Future<List<Notification>> getNotificationsByClientId(int clientId) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.rawQuery('SELECT Notification.id, Notification.creationDate, Notification.title, Notification.details, Notification.client_id FROM Notification, Client WHERE Client.id=Notification.client_id');

    List<Notification> notifications = result.isNotEmpty
        ? result.map((item) => Notification.fromDatabaseJson(item)).toList()
        : [];
    return notifications;
  }

  Future deleteAllNotificationsByClientId(int clientId) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    result = await db.rawQuery('DELETE FROM Notification WHERE Notification.client_id=$clientId');
    return result;
  }

  //Update Client record
  Future<int> updateNotification(Notification notification) async {
    final db = await dbProvider.database;

    var result = await db.update(NOTIFICATIONTABLE, notification.toDatabaseJson(),
        where: "id = ?", whereArgs: [notification.id]);

    return result;
  }

  //Delete Client records
  Future<int> deleteNotification(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(NOTIFICATIONTABLE, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllNotifications() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      NOTIFICATIONTABLE,
    );
    return result;
  }
}