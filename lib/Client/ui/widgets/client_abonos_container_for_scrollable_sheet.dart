import 'dart:io';

import 'package:clientmanagerapp/Abono/bloc/abono_bloc.dart';
import 'package:clientmanagerapp/Abono/model/Abono.dart';
import 'package:clientmanagerapp/Abono/ui/widgets/abono_list.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Widgets/dark_text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientAbonosContainer extends StatelessWidget{
  Client client;

  AbonoBloc abonoBloc;
  ClientAbonosContainer({@required this.client});


  _createAlertDialog(BuildContext context){
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();



    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        backgroundColor: Color(0xff292b2f),
        title: Text("Agregar Abono",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: FormBuilder(
          key: _fbKey,
          initialValue: {
            'date': DateTime.now(),
            'accept_terms': false,
          },
          autovalidate: true,
          child: DarkTextFormInput(
            maxLines: 1,
            attribute: "abono",
            hintText: "Abono",
            errorText: "Espacio vacio",
            iconData: Icons.monetization_on,
            validators: [
              FormBuilderValidators.numeric(),
              FormBuilderValidators.required()
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            color: Color(0xff43b581),
            child: Text("Agregar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: (){
              if (_fbKey.currentState.saveAndValidate()) {
                //SE CREA EL ABONO
                print("CLIENT ID: ${client.id}");
                abonoBloc.addAbono(Abono(
                  creationDate: DateTime.now().toString(),
                  value: double.parse(_fbKey.currentState.value['abono']),
                  clientId: client.id,
                ));
                Navigator.pop(context);
              }
              else {
                print(_fbKey
                    .currentState.value['nombres'].runtimeType);
                print(_fbKey.currentState.value);
                print('validation failed');
              }
            },
          )
        ],
      );
    });

  }


  @override
  Widget build(BuildContext context) {
    abonoBloc = BlocProvider.of<AbonoBloc>(context);

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
              Text("Abonos", style: TextStyle(fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Color(0xfffafafa)),),
              FloatingActionButton(
                heroTag: "btn2",
                elevation: 0,
                mini: true,
                backgroundColor: Color(0xff43b581),
                onPressed: () => _createAlertDialog(context),
                child: Icon(
                    Icons.add
                ),
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 32),
        ),
        Container(
          height: scrollableHeight-titleHeight,
          child: AbonoList(client: client,),
        ),



        //Container Listview for expenses and incomes



        //now expense


      ],
    );
  }



}