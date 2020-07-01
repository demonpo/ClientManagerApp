import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/ui/screens/client_details_screen.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_list_item.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ClientList extends StatelessWidget{
  ClientBloc clientBloc;
  @override
  Widget build(BuildContext context) {
    clientBloc = BlocProvider.of<ClientBloc>(context);
    clientBloc.getClients();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        color: Color(0xff292b2f),
      ),

      child: StreamBuilder(
        stream: clientBloc.clients,
        builder: (context, AsyncSnapshot<List<Client>> snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              print("CLIENTLIST: WAITING");
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.none:
              print("CLIENTLIST: NONE");
              return Center(child: CircularProgressIndicator(),);
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


  _getClientListView(AsyncSnapshot<List<Client>> snapshot){
    if(snapshot.hasData){
      print("HAS DATA");
      return snapshot.data.length != 0
          ? ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, itemPosition) {
            Client client = snapshot.data[itemPosition];
            print("${client.photoPath} ${client.name}");
            return ClientListItem(
              client: client,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BlocProvider(
                  bloc: clientBloc,
                  child: ClientDetailsScreen(client: client,),
                )));
              },
              onLongPress: (){
                _settingModalBottomSheet(context,client.id);
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

  void _settingModalBottomSheet(context, int clientId){
    showModalBottomSheet(

        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text('Eliminar'),
                    onTap: () {
                      Navigator.pop(context);
                      clientBloc.deleteClientById(clientId);
                    }
                ),
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text('Editar'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        }
    );
  }

  }
