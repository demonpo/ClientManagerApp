import 'dart:io';

import 'package:clientmanagerapp/Abono/bloc/abono_bloc.dart';
import 'package:clientmanagerapp/Abono/model/Abono.dart';
import 'package:clientmanagerapp/Abono/ui/widgets/abono_list.dart';
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Notification/bloc/notification_bloc.dart';
import 'package:clientmanagerapp/Notification/ui/widgets/notification_list_by_client_id.dart';
import 'package:clientmanagerapp/Widgets/dark_text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientNotificationsContainer extends StatelessWidget{
  Client client;

  NotificationBloc notificationBloc;
  ClientBloc clientBloc;
  ClientNotificationsContainer({@required this.client});




  @override
  Widget build(BuildContext context) {
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    clientBloc = BlocProvider.of<ClientBloc>(context);

    double scrollableHeight = MediaQuery.of(context).size.height;
    double titleHeight = 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: titleHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Notificaciones", style: TextStyle(fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Color(0xfffafafa)),),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 32),
        ),
        Container(
          height: scrollableHeight-titleHeight,
          child: NotificationListByClientId(client: client,),
        ),



        //Container Listview for expenses and incomes



        //now expense


      ],
    );
  }



}