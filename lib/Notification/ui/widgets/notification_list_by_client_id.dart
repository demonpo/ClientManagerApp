// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

// Project imports:
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Notification/bloc/notification_bloc.dart';
import 'package:clientmanagerapp/Notification/model/Notification.dart' as notif;
import 'notification_list_item.dart';

class NotificationListByClientId extends StatelessWidget {
  NotificationBloc notificationBloc;
  Client client;
  List<notif.Notification> notificationsById;
  NotificationListByClientId({this.client});

  @override
  Widget build(BuildContext context) {
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    notificationBloc.getNotifications();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: StreamBuilder(
        stream: notificationBloc.notifications,
        builder: (context, AsyncSnapshot<List<notif.Notification>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              print("NOTIFICATIONLIST: WAITING");
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.none:
              print("NOTIFICATIONLIST: NONE");
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              print("NOTIFICATIONLIST: ACTIVE");
              return _getNotificationListView(snapshot);
            case ConnectionState.done:
              print("NOTIFICATIONLIST: DONE");
              return _getNotificationListView(snapshot);
            default:
              print("NOTIFICATIONLIST: DEFAULT");
              return null;
          }
        },
      ),
    );
  }

  _getNotificationListView(AsyncSnapshot<List<notif.Notification>> snapshot) {
    if (snapshot.hasData) {
      print("HAS DATA");

      if (snapshot.data.length != 0) {
        notificationsById = snapshot.data
            .where((element) => element.clientId == client.id)
            .toList();
        return ListView.builder(
            itemCount: notificationsById.length,
            itemBuilder: (context, itemPosition) {
              notif.Notification notification = notificationsById[itemPosition];
              return NotificationListItem(
                notification: notification,
                onLongPress: () {
                  _settingModalBottomSheet(context, notification.id);
                },
              );
            });
      } else {
        return Container();
      }
    } else {
      print("NO DATA");
      return Center(
        child: Container(),
      );
    }
  }

  void _settingModalBottomSheet(context, int notificationId) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Eliminar'),
                    onTap: () {
                      Navigator.pop(context);
                      notificationBloc.deleteNotificationById(notificationId);
                    }),
              ],
            ),
          );
        });
  }
}
