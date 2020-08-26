class Notification {
  int id;
  String creationDate;
  String title;
  String details;
  int clientId;

  Notification(
      {this.id, this.creationDate, this.title, this.details, this.clientId});

  factory Notification.fromDatabaseJson(Map<String, dynamic> data) =>
      Notification(
        //This will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Client object
        id: data['id'],
        creationDate: data["creationDate"],
        title: data['title'],
        details: data["details"],
        clientId: data["client_id"],
      );
  Map<String, dynamic> toDatabaseJson() => {
        //This will be used to convert Todo objects that
        //are to be stored into the datbase in a form of JSON
        "id": this.id,
        "creationDate": this.creationDate,
        "title": this.title,
        "details": this.details,
        "client_id": this.clientId,
      };
}
