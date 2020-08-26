// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Notification/bloc/notification_bloc.dart';
import 'package:clientmanagerapp/Notification/ui/widgets/notification_list.dart';

class NotificationScreen extends StatelessWidget {
  ClientBloc clientBloc;
  NotificationBloc notificationBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationList(),
    );
  }
}
