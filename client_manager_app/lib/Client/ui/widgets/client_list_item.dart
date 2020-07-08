import 'dart:io';

import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:flutter/material.dart';

class ClientListItem extends StatelessWidget{
  Client client;
  VoidCallback onLongPress;
  VoidCallback onTap;

  ClientListItem({this.client, this.onLongPress, this.onTap});
  @override
  Widget build(BuildContext context) {
    final hasPhoto = client.photoPath == "" ? false : true;
    //final hasPhoto = client.photoPath == null ? false : true;

    final clientPhoto = Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(
          right: 20.0
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff43b581),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          hasPhoto ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(client.photoPath)),
              ),
            ),
          ) :  Container(),
        ],
      )
    );


    final clientDetails = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //client Name
          Container(
            width: 260,
            child: Text(
              "${client.name} ${client.lastName}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),

          //Client details
          Text(
            client.email,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xffa2a3a7),
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        height: 80,
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
          color: Color(0xff36393f),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: <Widget>[
            clientPhoto,
            clientDetails,
          ],


        ),

      ),
    );
  }

}