import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DarkImagePickerForm extends StatelessWidget{
  double height;
  double width;

  String attribute;
  List<String Function(dynamic)> validators;
  DarkImagePickerForm({@required this.validators, @required this.attribute, @required this.height,@required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment(0.0, 0.0),

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
        shape: BoxShape.circle,
      ),
      child: FormBuilderImagePicker(
        maxImages: 1,
        decoration: InputDecoration(
        ),
        validators: validators,
        attribute: attribute,




      ),
    );
  }


}