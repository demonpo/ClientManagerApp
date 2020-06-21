import 'package:flutter/material.dart';

class ClientListItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final clientPhoto = Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(
          right: 20.0
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff43b581),
          /*
          image: DecorationImage(
              fit: BoxFit.cover,
              //image: AssetImage(),
          )*/
      ),
      child: Icon(
        Icons.person,
        color: Colors.white,
      ),
    );


    final clientDetails = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //client Name
          Text(
            "Dummy Name",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          //Client details
          Text(
            "Dummy Details",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xffa2a3a7),
            ),
          ),
        ],
      ),
    );

    return Container(
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

    );
  }

}