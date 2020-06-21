import 'package:clientmanagerapp/Client/ui/screens/client_register_screen.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_list.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_register_form.dart';
import 'package:flutter/material.dart';

class ClientListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ClientList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ClientRegisterScreen()));
        },
      ),

    );
  }


}