import 'dart:async';


import 'package:clientmanagerapp/Notification/model/Notification.dart';
import 'package:clientmanagerapp/Notification/repository/notification_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class NotificationBloc extends Bloc{
  //Get instance of the Repository
  final _notificationRepository = NotificationRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _notificationController = StreamController<List<Notification>>.broadcast();

  get notifications => _notificationController.stream;

  NotificationBloc() {
    getNotifications();
  }

  getNotifications({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    print("GETNOTIFICATIONS");
    _notificationController.sink.add(await _notificationRepository.getAllNotifications(query: query));
  }

  Future<List<Notification>>getNotificationsByClientId(int clientId) async{
    //Requiere trabajar en la implementacion, es opcional
    getNotifications();
    return await _notificationRepository.getNotificationsByClientId(clientId);
  }

  Future<List<Notification>> getAllNotifications() async{
    return await _notificationRepository.getAllNotifications();

  }

  addNotification(Notification notification) async {
    await _notificationRepository.insertNotification(notification);
    getNotifications();
  }

  updateNotification(Notification notification) async {
    await _notificationRepository.updateNotification(notification);
    getNotifications();
  }

  deleteNotificationById(int id) async {
    _notificationRepository.deleteNotificationById(id);
    getNotifications();
  }

  deleteAllnotificationsByClientId(int clientId) {
    _notificationRepository.deleteAllNotificationsByClientId(clientId);
    getNotifications();
  }


  dispose() {
    print("dispose");
    //_clientController.close();
  }
}