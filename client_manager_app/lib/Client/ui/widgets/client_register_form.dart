import 'dart:io';

import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Widgets/dark_dropdown_picker_form.dart';
import 'package:clientmanagerapp/Widgets/dark_image_picker.dart';
import 'package:clientmanagerapp/Widgets/dark_phone_input_form_2.dart';
import 'package:clientmanagerapp/Widgets/dark_text_form_input.dart';
import 'package:clientmanagerapp/Widgets/dark_time_picker_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ClientRegisterForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ClientRegisterForm();
  }


}

class _ClientRegisterForm extends State<ClientRegisterForm>{
  final darkImagePicker = DarkImagePicker( size: 100,);
  ClientBloc clientBloc;
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  DarkPhoneInputForm2 darkPhoneInputForm2 = DarkPhoneInputForm2(hintText: "Numero de Telefono",);



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
                      darkImagePicker,
                      DarkTextFormInput(
                        maxLines: 1,
                        attribute: "nombres",
                        hintText: "Ingrese Nombre",
                        errorText: "Espacio vacio",
                        iconData: Icons.person,
                        validators: [

                        ],
                      ),
                      DarkTextFormInput(
                        maxLines: 1,
                        attribute: "apellidos",
                        hintText: "Ingrese Apellido",
                        errorText: "Espacio vacio",
                        iconData: Icons.person,
                        validators: [

                        ],
                      ),
                      DarkTextFormInput(
                        maxLines: 1,
                        attribute: "cedula",
                        hintText: "Ingrese numero de cedula",
                        errorText: "Espacio vacio",
                        iconData: Icons.perm_identity,
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.required(),
                        ],
                      ),
                      DarkTextFormInput(
                        maxLines: 1,
                        attribute: "email",
                        hintText: "Ingrese email",
                        errorText: "Espacio vacio",
                        iconData: Icons.email,
                        validators: [
                          FormBuilderValidators.email(),
                        ],
                      ),
                      darkPhoneInputForm2,
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

                      DarkTimePickerForm(
                        attribute: "inscriptionDate",
                        labelText: "Fecha de inscripcion",
                        validators: [
                          FormBuilderValidators.required()
                        ],
                      ),

                      DarkTextFormInput(
                        maxLines: 1,
                        attribute: "mensualidad",
                        hintText: "Ingrese valor mensual",
                        errorText: "Espacio vacio",
                        iconData: Icons.monetization_on,
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.required()
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.green,
                    child: Text(
                      'Aceptar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        var inscriptionDate = DateTime.parse(_fbKey.currentState.value['inscriptionDate'].toString());
                        var dealinePaymentDate = inscriptionDate.add(Duration(days: 30));
                        print(_fbKey
                            .currentState.value['nombres'].runtimeType);
                        print(_fbKey.currentState.value);
                        print(darkImagePicker.image == null ? "" : darkImagePicker.image.path);
                        clientBloc.addClient(Client(
                          photoPath: darkImagePicker.image == null ? "" : darkImagePicker.image.path,
                          name: _fbKey.currentState.value['nombres'],
                          lastName: _fbKey.currentState.value['apellidos'],
                          cedula: _fbKey.currentState.value['cedula'],
                          email: _fbKey.currentState.value['email'],
                          phoneNumber: darkPhoneInputForm2.phoneNumber,
                          gender: _fbKey.currentState.value['genero'],
                          birthday: _fbKey.currentState.value['birthday'].toString(),
                          inscriptionDate:  _fbKey.currentState.value['inscriptionDate'].toString(),
                          deadLinePaymentDate: dealinePaymentDate.toString(),
                          debtValue: double.parse(_fbKey.currentState.value['mensualidad']),
                          valorMensual:  double.parse(_fbKey.currentState.value['mensualidad'])
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      ),
                    color: Colors.red,
                    child: Text(
                      'Resetear',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),

    );
  }


}