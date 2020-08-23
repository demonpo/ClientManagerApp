import 'package:clientmanagerapp/Abono/bloc/abono_bloc.dart';
import 'package:clientmanagerapp/Abono/model/Abono.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'abono_list_item.dart';



class AbonoList extends StatelessWidget{
  AbonoBloc abonoBloc;
  Client client;
  List<Abono> abonosById;
  AbonoList({this.client});

  @override
  Widget build(BuildContext context) {
    abonoBloc = BlocProvider.of<AbonoBloc>(context);
    abonoBloc.getAbonos();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,


      child: StreamBuilder(
        stream: abonoBloc.abonos,
        builder: (context, AsyncSnapshot<List<Abono>> snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              print("ABONOLIST: WAITING");
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.none:
              print("ABONOLIST: NONE");
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
              print("ABONOLIST: ACTIVE");
              return _getAbonoListView(snapshot);
            case ConnectionState.done:
              print("ABONOLIST: DONE");
              return _getAbonoListView(snapshot);
            default:
              print("ABONOLIST: DEFAULT");
              return null;

          }
        },

      ),
    );
  }


  _getAbonoListView(AsyncSnapshot<List<Abono>> snapshot) {
    if(snapshot.hasData){
      print("HAS DATA");

      if(snapshot.data.length != 0){
        abonosById = snapshot.data.where((element) => element.clientId == client.id).toList();
        abonosById.forEach((element) {
          print("ABONOCREATIONDATE${element.creationDate} ${element.value} CLIENTID:${element.clientId}");
        });
        return ListView.builder(
          itemCount: abonosById.length,
            itemBuilder: (context, itemPosition) {
          Abono abono = abonosById[itemPosition];
          print("ABONOCREATIONDATE${abono.creationDate} ${abono.value} ABONOID:${abono.clientId}");
          return AbonoListItem(
            abono: abono,
            onLongPress: (){
              _settingModalBottomSheet(context,abono.id);
            },
          );
        }
        );
      }
      else{
        return Container();
      }
    }

    else {
      print("NO DATA");
      return Center(
        child: Container(),
      );

    }
  }


  void _settingModalBottomSheet(context, int abonoId){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Eliminar'),
                    onTap: () {
                      Navigator.pop(context);
                      abonoBloc.deleteAbonoById(abonoId);
                    }
                ),

              ],
            ),
          );
        }
    );
  }

}