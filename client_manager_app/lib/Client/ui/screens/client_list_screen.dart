import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/ui/screens/client_register_screen.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_list.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ClientListScreen extends StatelessWidget{
  ClientBloc clientBloc;

  @override
  Widget build(BuildContext context) {

    clientBloc = BlocProvider.of<ClientBloc>(context);
    // TODO: implement build
    return Scaffold(
      body: ClientList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BlocProvider(
            bloc: clientBloc,
            child: ClientRegisterScreen(),
          )));
        },
      ),

    );
  }


}