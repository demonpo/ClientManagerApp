// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DarkDropdownPickerForm extends StatelessWidget {
  String attribute;
  String hintText;
  List<String> items;
  List<String Function(dynamic)> validators;
  DarkDropdownPickerForm(
      {@required this.validators,
      @required this.attribute,
      @required this.items,
      @required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xff36393f),
      ),
      child: Container(
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
            enabledBorder: InputBorder.none,
          ),
          // initialValue: 'Male',
          hint: Text(
            hintText,
            style: TextStyle(
              color: Color(0xff686c77),
            ),
          ),

          validators: validators,
          items: items
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Container(
                      child: Text(
                        "$value",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
