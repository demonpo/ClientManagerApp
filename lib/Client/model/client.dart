// Flutter imports:
import "package:flutter/cupertino.dart";
class Client {
  int id;
  //description is the text we see on
  //main screen card text
  String cedula;
  String photoPath;
  String name;
  String lastName;
  String birthday;
  String email;
  String phoneNumber;
  String gender;
  bool isActive;
  String inscriptionDate;
  bool hasDebt;
  num debtValue;
  String deadLinePaymentDate;
  num valorMensual;

  //When using curly braces { } we note dart that
  //the parameters are optional
  Client(
      {this.id,
      this.cedula,
      this.photoPath = "",
      this.name = "",
      this.lastName = "",
      this.birthday = "",
      this.email = "",
      this.phoneNumber = "",
      this.gender = "",
      this.inscriptionDate = "",
      this.hasDebt = false,
      @required this.debtValue,
      this.deadLinePaymentDate = "",
      @required this.valorMensual,
      this.isActive = true});

  factory Client.fromDatabaseJson(Map<String, dynamic> data) => Client(
        //This will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Client object
        id: data["id"],
        cedula: data["cedula"],
        photoPath: data["photoPath"],
        name: data["name"],
        lastName: data["lastName"],
        birthday: data["birthday"],
        email: data["email"],
        gender: data["gender"],
        phoneNumber: data["phoneNumber"],
        inscriptionDate: data["inscription_date"],
        hasDebt: data["has_debt"] == 0 ? false : true,
        debtValue: data["debt_value"],
        deadLinePaymentDate: data["deadline_payment_date"],
        valorMensual: data["valor_mensual"],
        isActive: data["is_active"] == 0 ? false : true,
      );
  Map<String, dynamic> toDatabaseJson() => {
        //This will be used to convert Todo objects that
        //are to be stored into the database in a form of JSON
        "id": id,
        "cedula": cedula,
        "photoPath": photoPath,
        "name": name,
        "lastName": lastName,
        "birthday": birthday,
        "email": email,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "inscription_date": inscriptionDate,
        "has_debt": hasDebt == false ? 0 : 1,
        "debt_value": debtValue,
        "deadline_payment_date": deadLinePaymentDate,
        "valor_mensual": valorMensual,
        "is_active": isActive == false ? 0 : 1,
      };

  void renovarSubscripcion() {
    isActive = true;
    deadLinePaymentDate =
        DateTime.now().add(Duration(days: 30)).toString();
    debtValue = debtValue + valorMensual;
  }

  void setAsInactive() {
    isActive = false;
    debtValue = debtValue - valorMensual;
  }

  void setAsDebtor() {
    isActive = false;
    hasDebt = true;
  }

/*void setAsActive(){
    this.isActive = true;
    this.deadLinePaymentDate = DateTime.now().add(Duration(days: 30)).toString();
    this.debtValue = valorMensual + debtValue;
  } */

}
