class Abono {
  int id;
  String creationDate;
  double value;
  int clientId;

  Abono({this.id, this.creationDate, this.value, this.clientId});

  factory Abono.fromDatabaseJson(Map<String, dynamic> data) => Abono(
        //This will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Client object
        id: data['id'],
        creationDate: data["creation_date"],
        value: data['value'],
        clientId: data["client_id"],
      );
  Map<String, dynamic> toDatabaseJson() => {
        //This will be used to convert Todo objects that
        //are to be stored into the datbase in a form of JSON
        "id": this.id,
        "creation_date": this.creationDate,
        "value": this.value,
        "client_id": this.clientId,
      };
}
