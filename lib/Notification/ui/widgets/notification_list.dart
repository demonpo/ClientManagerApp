import 'package:clientmanagerapp/Abono/bloc/abono_bloc.dart';
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Client/ui/screens/client_details_screen.dart';
import 'package:clientmanagerapp/Notification/bloc/notification_bloc.dart';
import 'package:clientmanagerapp/Notification/model/Notification.dart' as notif;
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'notification_list_item.dart';

class NotificationList extends StatelessWidget{
  ClientBloc clientBloc;
  AbonoBloc abonoBloc;
  NotificationBloc notificationBloc;

  @override
  Widget build(BuildContext context) {

    clientBloc = BlocProvider.of<ClientBloc>(context);
    abonoBloc = BlocProvider.of<AbonoBloc>(context);
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    notificationBloc.getNotifications();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        color: Color(0xff292b2f),
      ),

      child: StreamBuilder(
        stream: notificationBloc.notifications,
        builder: (context, AsyncSnapshot<List<notif.Notification>> snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              print("NOTIFICATIONLIST: WAITING");
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.none:
              print("NOTIFICATIONLIST: NONE");
              return Center(child: CircularProgressIndicator(),);
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


  _getNotificationListView(AsyncSnapshot<List<notif.Notification>> snapshot){
    if(snapshot.hasData){
      print("HAS DATA");
      return snapshot.data.length != 0
          ? ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, itemPosition) {
            notif.Notification notification = snapshot.data[itemPosition];
            print("${notification.title} ${notification.details}");
            return NotificationListItem(
              notification: notification,
              onLongPress: () async{
                Client client = await clientBloc.getClientById(notification.clientId);
                await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BlocProvider(
                  bloc: clientBloc,
                  child: BlocProvider(
                    bloc: abonoBloc,
                    child: BlocProvider(
                      bloc: notificationBloc,
                      child: ClientDetailsScreen(client: client,),
                    ),
                  )
                )
                )
                );
              },
            );
          }
      )

      //Si no hay datos en la lista se preseneta este contenedor
          : Container();
    }

    else {
      print("NO DATA");
      return Center(
        child: Container(),
      );

    }





  }

}