import 'package:clientmanagerapp/Client/ui/widgets/client_list_item.dart';
import 'package:flutter/material.dart';

class ClientList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        color: Color(0xff292b2f),
      ),

      child: ListView(
        children: <Widget>[
          ClientListItem(),
          ClientListItem(),
        ],
      ),


    );
  }


}