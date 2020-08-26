// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

// Project imports:
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_abonos_container_for_scrollable_sheet.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_details_container_for_scrollable_sheet.dart';
import 'package:clientmanagerapp/Client/ui/widgets/client_notifications_container_for_scrollable_sheet.dart';

class ClientDetailsScreen extends StatefulWidget {
  Client client;
  ClientBloc clientBloc;
  ClientDetailsScreen({this.client});

  @override
  State<StatefulWidget> createState() {
    return _ClientDetailsScreen();
  }
}

class _ClientDetailsScreen extends State<ClientDetailsScreen> {
  int index = 0;

  void onTapTapped(int index) {
    setState(() {
      this.index = index;
    });
  }

  _createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            backgroundColor: Color(0xff292b2f),
            title: Text(
              widget.client.isActive
                  ? "Desactivar cliente"
                  : "Reactivar cliente",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: Container(
              child: Text(
                widget.client.isActive
                    ? "Seguro quieres desactivar a este cliente?"
                    : "Seguro quieres reactivar a este cliente?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                color: Color(0xff43b581),
                child: Text(
                  "Si",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (widget.client.isActive) {
                    widget.client.setAsInactive();
                    widget.clientBloc.updateClient(widget.client);
                  } else {
                    widget.client.renovarSubscripcion();
                    widget.clientBloc.updateClient(widget.client);
                  }
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                color: Colors.red,
                child: Text(
                  "No",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    widget.clientBloc = BlocProvider.of<ClientBloc>(context);
    final hasPhoto = widget.client.photoPath == "" ? false : true;

    List<Widget> widgetList = [
      ClientDetailsContainer(
        client: widget.client,
      ),
      ClientAbonosContainer(
        client: widget.client,
      ),
      ClientNotificationsContainer(
        client: widget.client,
      ),
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
                          backgroundColor: Color(0xff43b581),
                          backgroundImage: hasPhoto
                              ? FileImage(File(widget.client.photoPath))
                              : null,
                          child: !hasPhoto
                              ? Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )
                              : Container(),
                        ),
                        margin: EdgeInsets.only(right: 15),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.client.name} ${widget.client.lastName}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () => onTapTapped(0),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff2f3136),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xff43b581),
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Detalles",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xffeaebec)),
                              ),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Icon(
                                  Icons.attach_money,
                                  color: Color(0xff43b581),
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Abonos",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xffeaebec)),
                              ),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Icon(
                                  Icons.notifications,
                                  color: Color(0xff43b581),
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Avisos",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xffeaebec)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _createAlertDialog(context);
                      setState(() {});
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          color: widget.client.isActive
                              ? Colors.red
                              : Color(0xff43b581),
                        ),
                        child: Center(
                          child: Text(
                            widget.client.isActive
                                ? "Desactivar cliente"
                                : "Activar cliente",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),

            //draggable sheet
            DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                      color: Color(0xff36393f),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
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
