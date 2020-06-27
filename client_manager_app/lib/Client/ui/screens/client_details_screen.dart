import 'dart:io';

import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_details_container_for_scrollable_sheet.dart';
import 'package:flutter/material.dart';


class ClientDetailsScreen extends StatefulWidget{

  Client client;
  ClientDetailsScreen({this.client});

  @override
  State<StatefulWidget> createState() {
    return _ClientDetailsScreen();
  }

}

class _ClientDetailsScreen extends State<ClientDetailsScreen>{

  int index=0;


  void onTapTapped(int index){
    setState(() {
      this.index = index;
    });

  }


  @override
  Widget build(BuildContext context) {

    List<Widget> widgetList = [
      ClientDetailsContainer(client: widget.client,),
      Container(
        margin: EdgeInsets.only(top:60, left: 30),
        child: Text("Abono"),
      ),
      Container(
        margin: EdgeInsets.only(top:60, left: 30),
        child: Text("Avisos"),
      )
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Color(0xff292b2f),
        child: Stack(
          children: <Widget>[
            //Container for top data
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(widget.client.photoPath)),
                        ),
                        margin: EdgeInsets.only(right: 15),
                      ),
                      Text("${widget.client.name} ${widget.client.lastName}", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),),


                    ],
                  ),


                  SizedBox(height : 24,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: ()=>onTapTapped(0),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff2f3136),
                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                ),
                                child: Icon(Icons.person, color: Color(0xff43b581), size: 30,),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Detalles", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xffeaebec)),),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () => onTapTapped(1),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff2f3136),
                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                ),
                                child: Icon(Icons.attach_money, color: Color(0xff43b581), size: 30,),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Abonos", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xffeaebec)),),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () => onTapTapped(2),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff2f3136),
                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                ),
                                child: Icon(Icons.notifications, color: Color(0xff43b581), size: 30,),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Avisos", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xffeaebec)),),
                            ],
                          ),
                        ),
                      ),


                    ],
                  )

                ],
              ),
            ),


            //draggable sheet
            DraggableScrollableSheet(
              builder: (context, scrollController){
                return Container(
                  decoration: BoxDecoration(
                      color: Color(0xff36393f),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                  ),
                  child: SingleChildScrollView(
                    child: widgetList[index],

                    controller: scrollController,
                  ),
                );
              },
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 1,
            )
          ],
        ),
      ),
    );
  }

}