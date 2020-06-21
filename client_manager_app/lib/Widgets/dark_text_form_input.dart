import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DarkTextFormInput extends StatelessWidget{

  String attribute;
  String hintText;
  String errorText;
  IconData iconData;
  List<String Function(dynamic)> validators;
  DarkTextFormInput({@required this.iconData, @required this.validators, @required this.hintText, @required this.errorText, @required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.only(
        left: 10,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Color(0xff36393f),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),

      child: FormBuilderTextField(
        attribute: attribute,
        validators: validators,
        decoration: InputDecoration(
          icon: Icon(iconData),
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          //labelText: 'Name *',
        ),
        style: TextStyle(
          fontSize: 20,
          color: Color(0xff96979c),

        ),
      ),
    );
  }


}