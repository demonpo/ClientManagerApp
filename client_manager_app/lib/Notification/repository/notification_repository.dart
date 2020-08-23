import 'package:clientmanagerapp/Notification/dao/notificationDao.dart';
import 'package:clientmanagerapp/Notification/model/Notification.dart';

class NotificationRepository {
  final notificationDao = NotificationDao();

  Future getAllNotifications({String query}) => notificationDao.getNotifications(query: query);

  Future<List<Notification>> getNotificationsByClientId(int clientId) =>
      notificationDao.getNotificationsByClientId(clientId);

  Future insertNotification(Notification notification) => notificationDao.createNotification(notification);

  Future updateNotification(Notification notification) => notificationDao.updateNotification(notification);

  Future deleteNotificationById(int id) => notificationDao.deleteNotification(id);

  //We are not going to use this in the demo
  Future deleteAllNotifications() => notificationDao.deleteAllNotifications();

  Future deleteAllNotificationsByClientId(int clientId) =>
      notificationDao.deleteAllNotificationsByClientId(clientId);

}