import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DarkDropdownPickerForm extends StatelessWidget{

  String attribute;
  String labelText;
  String hintText;
  List<String> items;
  List<String Function(dynamic)> validators;
  DarkDropdownPickerForm({@required this.validators, @required this.attribute, @required this.items, @required this.labelText, @required this.hintText});

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

      child: FormBuilderDropdown(

        attribute: attribute,
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: InputBorder.none,

        ),
        // initialValue: 'Male',
        hint: Text(hintText),
        validators: validators,
        items: items
            .map((value) => DropdownMenuItem(
            value: value,
            child: Container(
              child: Text(
                "$value",
                style: TextStyle(
                  color: Color(0xff96979c),
                ),
              ),
            ),
        )).toList(),
      ),
    );
  }


}