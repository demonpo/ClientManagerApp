import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class DarkTimePickerForm extends StatelessWidget{

  String attribute;
  String labelText;
  List<String Function(dynamic)> validators;
  DarkTimePickerForm({@required this.validators, @required this.attribute, @required this.labelText});

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
        right: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xff36393f),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),

      child: FormBuilderDateTimePicker(
        attribute: attribute,
        inputType: InputType.date,
        format: DateFormat("yyyy-MM-dd"),
        style: TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xff686c77),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

        ),
      ),
    );
  }


}