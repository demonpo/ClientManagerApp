// Flutter imports:
import "package:flutter/material.dart";

// Package imports:
import "package:generic_bloc_provider/generic_bloc_provider.dart";

// Project imports:
import "package:clientmanagerapp/Abono/bloc/abono_bloc.dart";
import "package:clientmanagerapp/Client/bloc/client_bloc.dart";
import "package:clientmanagerapp/Client/model/client.dart";
import "package:clientmanagerapp/Client/ui/screens/client_details_screen.dart";
import "package:clientmanagerapp/Client/ui/widgets/client_list_item.dart";
import "package:clientmanagerapp/Notification/bloc/notification_bloc.dart";

class ClientList extends StatelessWidget {
  ClientBloc clientBloc;
  AbonoBloc abonoBloc;
  NotificationBloc notificationBloc;
  @override
  Widget build(BuildContext context) {
    clientBloc = BlocProvider.of<ClientBloc>(context);
    abonoBloc = BlocProvider.of<AbonoBloc>(context);
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    clientBloc.getClients();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        color: Color(0xff292b2f),
      ),
      child: StreamBuilder(
        stream: clientBloc.clients,
        builder: (context, AsyncSnapshot<List<Client>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              print("CLIENTLIST: WAITING");
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.none:
              print("CLIENTLIST: NONE");
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              print("CLIENTLIST: ACTIVE");
              return _getClientListView(snapshot);
            case ConnectionState.done:
              print("CLIENTLIST: DONE");
              return _getClientListView(snapshot);
            default:
              print("CLIENTLIST: DEFAULT");
              return null;
          }
        },
      ),
    );
  }

  Widget _getClientListView(AsyncSnapshot<List<Client>> snapshot) {
    if (snapshot.hasData) {
      print("HAS DATA");
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                var client = snapshot.data[itemPosition];
                print("${client.photoPath} ${client.name}");
                return ClientListItem(
                  client: client,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => BlocProvider(
                                  bloc: clientBloc,
                                  child: BlocProvider(
                                    bloc: abonoBloc,
                                    child: BlocProvider(
                                      bloc: notificationBloc,
                                      child: ClientDetailsScreen(
                                        client: client,
                                      ),
                                    ),
                                  ),
                                )));
                  },
                  onLongPress: () {
                    _settingModalBottomSheet(context, client.id);
                  },
                );
              })

          //Si no hay datos en la lista se preseneta este contenedor
          : Container();
    } else {
      print("NO DATA");
      return Center(
        child: Container(),
      );
    }
  }

  void _settingModalBottomSheet(context, int clientId) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text("Eliminar"),
                    onTap: () {
                      Navigator.pop(context);
                      clientBloc.deleteClientById(clientId);
                      abonoBloc.deleteAllAbonosByClientId(clientId);
                      notificationBloc
                          .deleteAllnotificationsByClientId(clientId);
                    }),
                ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text('Editar'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }
}
