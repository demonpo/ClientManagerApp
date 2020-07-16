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

    //Builder(builder: (context) {
    //});

    clientBloc = BlocProvider.of<ClientBloc>(context);

    const SnackBar submittedToast = SnackBar(content: Text('Form submitted'));

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

                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    key: Key('submit'),
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
                        print(darkImagePicker.image == null ? "" : darkImagePicker.image.path);
                        
                        clientBloc.addClient(Client(
                          photoPath: darkImagePicker.image == null ? "" : darkImagePicker.image.path,
                          name: _fbKey.currentState.value['nombres'],
                          lastName: _fbKey.currentState.value['apellidos'],
                          email: _fbKey.currentState.value['email'],
                          phoneNumber: darkPhoneInputForm2.phoneNumber,
                          gender: _fbKey.currentState.value['genero'],
                          birthday: _fbKey.currentState.value['birthday'].toString(),
                        ));
                        Scaffold.of(context).showSnackBar(submittedToast);
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