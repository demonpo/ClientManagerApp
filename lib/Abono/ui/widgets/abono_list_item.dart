
import 'package:clientmanagerapp/Abono/model/Abono.dart';
import 'package:flutter/material.dart';

class AbonoListItem extends StatelessWidget{
  Abono abono;
  VoidCallback onLongPress;


  AbonoListItem({this.abono, this.onLongPress});
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onLongPress: onLongPress,
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
          color: Color(0xff2f3136),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Dia de abono:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Text(abono.creationDate,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("valor abonado:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Text(abono.value.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff43b581),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}