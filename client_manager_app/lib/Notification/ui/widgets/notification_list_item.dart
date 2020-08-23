
import 'package:flutter/material.dart';
import "package:clientmanagerapp/Notification/model/Notification.dart" as notif;

class NotificationListItem extends StatelessWidget{
  notif.Notification notification;
  VoidCallback onLongPress;


  NotificationListItem({this.notification, this.onLongPress});
  @override
  Widget build(BuildContext context) {
    DateTime notificationCreationDate = DateTime.parse(notification.creationDate);


    return InkWell(
      onLongPress: onLongPress,
      child: Container(
        height: 120,
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        margin: EdgeInsets.only(
          top: 5,
          left: 10,
          right: 10,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: Color(0xff2f3136),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Notificación creada el:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Text("${notificationCreationDate.year}-${notificationCreationDate.month}-${notificationCreationDate.day}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Título:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Text(notification.title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff43b581),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(notification.details,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff43b581),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}