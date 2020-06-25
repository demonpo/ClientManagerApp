import 'dart:io';

import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Widgets/dark_dropdown_picker_form.dart';
import 'package:clientmanagerapp/Widgets/dark_text_form_input.dart';
import 'package:clientmanagerapp/Widgets/dark_time_picker_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:intl/intl.dart';
import 'package:clientmanagerapp/Widgets/dark_image_picker.dart';

class ClientRegisterForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ClientRegisterForm();
  }


}

class _ClientRegisterForm extends State<ClientRegisterForm>{
  ClientBloc clientBloc;
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final ValueChanged _onChanged = (val) => print(val);



  @override
  Widget build(BuildContext context) {

    clientBloc = BlocProvider.of<ClientBloc>(context);


    return Container(
      color: Color(0xff292b2f),
        child: ListView(
          children: <Widget>[
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff202225),
              ),
              child: Row( //App Bar
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: SizedBox(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 45,),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    ),
                  ),

                  Flexible(
                      child: Container(
                        child: Text(
                          "Ingrese nuevo cliente",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white
                          ),
                        ),
                      ))
                ],
              ),
            ),

            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false,
                  },
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      DarkImagePicker(
                        height: 100,
                        width: 100,
                      ),
                      DarkTextFormInput(
                        attribute: "nombres",
                        hintText: "Ingrese Nombre",
                        errorText: "Espacio vacio",
                        iconData: Icons.person,
                        validators: [

                        ],
                      ),
                      DarkTextFormInput(
                        attribute: "apellidos",
                        hintText: "Ingrese Apellido",
                        errorText: "Espacio vacio",
                        iconData: Icons.person,
                        validators: [

                        ],
                      ),
                      DarkTextFormInput(
                        attribute: "email",
                        hintText: "Ingrese email",
                        errorText: "Espacio vacio",
                        iconData: Icons.email,
                        validators: [
                          FormBuilderValidators.email(),
                        ],
                      ),
                      DarkTextFormInput(
                        attribute: "phoneNumber",
                        hintText: "Ingrese Numero de Telefono",
                        errorText: "Espacio vacio",
                        iconData: Icons.phone,
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                      ),
                      DarkDropdownPickerForm(
                        attribute: "genero",
                        hintText: "Genero",
                        items: ["Masculino","Femenino","Otros"],
                        validators: [
                          FormBuilderValidators.required()
                        ],
                      ),
                      DarkTimePickerForm(
                        attribute: "birthday",
                        labelText: "Fecha de nacimiento",
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey
                            .currentState.value['nombres'].runtimeType);
                        print(_fbKey.currentState.value);
                        print('validation OK');
                        clientBloc.addClient(Client(

                          name: _fbKey.currentState.value['nombres'],
                          lastName: _fbKey.currentState.value['apellidos'],
                          email: _fbKey.currentState.value['email'],
                          phoneNumber: _fbKey.currentState.value['phoneNumber'],
                          gender: _fbKey.currentState.value['genero'],
                          birthday: _fbKey.currentState.value['birthday'].toString(),
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
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),

    );
  }


}