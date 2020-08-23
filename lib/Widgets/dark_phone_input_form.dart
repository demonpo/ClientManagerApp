import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DarkPhoneInputForm extends StatelessWidget{

  String attribute;
  String hintText;
  String errorText;
  String dialogTitle;
  String initialPhoneNumber = "";
  String phoneCountryIsoCode;
  List<String Function(dynamic)> validators;
  DarkPhoneInputForm({@required this.validators, @required this.hintText, @required this.errorText, @required this.attribute,@required this.phoneCountryIsoCode, @required this.dialogTitle});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.only(
      ),
      decoration: BoxDecoration(
        color: Color(0xff36393f),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),

      child: FormBuilderPhoneField(

        attribute: attribute,
        validators: validators,
        dialogTitle: Text(dialogTitle),
        dialogTextStyle: TextStyle(
          color: Colors.black,
        ),
        keyboardType: TextInputType.phone,
        maxLines: 1,
        defaultSelectedCountryIsoCode: phoneCountryIsoCode,
        initialValue: initialPhoneNumber,
        autofocus: false,
        decoration: InputDecoration(

          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff686c77),
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          //labelText: 'Name *',
        ),
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,

        ),
      ),
    );
  }


}