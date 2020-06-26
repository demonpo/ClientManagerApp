import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:flutter/material.dart';

class ClientDetailsContainer extends StatelessWidget{
  Client client;
  ClientDetailsContainer({@required this.client});

  @override
  Widget build(BuildContext context) {
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
              Text("Detalles", style: TextStyle(fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Color(0xfffafafa)),),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 32),
        ),
        Container(
          height: scrollableHeight-titleHeight,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Numero de telefono:", style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500]),),
                    Text(client.phoneNumber, style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),)
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 32),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Email:", style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500]),),
                    Text(client.email, style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),)
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 32),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Fecha de nacimiento:", style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500]),),
                    Text(client.birthday, style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),)

                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 32),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Genero:", style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500]),),
                    Text(client.gender, style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),)
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 32),
              ),

            ],
          ),
        ),



        //Container Listview for expenses and incomes



        //now expense


      ],
    );
  }



}