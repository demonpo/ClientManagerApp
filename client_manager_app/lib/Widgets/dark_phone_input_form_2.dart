import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class DarkPhoneInputForm2 extends StatefulWidget{
  String phoneNumber;
  String hintText;
  DarkPhoneInputForm2({this.hintText});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DarDarkPhoneInputForm2();
  }

}

class _DarDarkPhoneInputForm2 extends State<DarkPhoneInputForm2>{
  TextEditingController controller = TextEditingController();
  String initialCountry = 'EC';
  PhoneNumber number = PhoneNumber(isoCode: "EC");

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
        left: 20
      ),
      decoration: BoxDecoration(
        color: Color(0xff36393f),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),

      child: InternationalPhoneNumberInput(
        key: Key('cell'),
        onInputChanged: (PhoneNumber number) {
          widget.phoneNumber = number.phoneNumber;
          print(number.phoneNumber);
        },
        onInputValidated: (bool value) {
          print(value);
        },
        textStyle: TextStyle(
          color: Colors.white,
        ),
        inputDecoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0xff686c77),
          ),
          focusedBorder: InputBorder.none,
        ),
        ignoreBlank: false,
        autoValidate: false,
        selectorTextStyle: TextStyle(color: Colors.white),
        initialValue: number,
        textFieldController: controller,
        inputBorder: OutlineInputBorder(),
        selectorType: PhoneInputSelectorType.DIALOG,


      ),
    );
  }

}