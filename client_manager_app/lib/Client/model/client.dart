class Client {
  int id;
  //description is the text we see on
  //main screen card text
  String photoPath;
  String name;
  String lastName;
  String birthday;
  String email;
  String phoneNumber;
  String gender;
  bool isDone;
  //When using curly braces { } we note dart that
  //the parameters are optional
  Client({
    this.id,
    this.photoPath,
    this.name,
    this.lastName,
    this.birthday,
    this.email,
    this.phoneNumber,
    this.gender,
    this.isDone = false});

  factory Client.fromDatabaseJson(Map<String, dynamic> data) => Client(
    //This will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Client object
    id: data['id'],
    photoPath: data["photoPath"],
    name: data['name'],
    lastName: data["lastName"],
    birthday: data["birthday"],
    email: data["email"],
    gender: data["gender"],
    phoneNumber: data["phoneNumber"],
    //Since sqlite doesn't have boolean type for true/false
    //we will 0 to denote that it is false
    //and 1 for true
    isDone: data['is_done'] == 0 ? false : true,
  );
  Map<String, dynamic> toDatabaseJson() => {
    //This will be used to convert Todo objects that
    //are to be stored into the datbase in a form of JSON
    "id": this.id,
    "photoPath" : this.photoPath,
    "name": this.name,
    "lastName" : this.lastName,
    "birthday" : this.birthday,
    "email" : this.email,
    "gender" :  this.gender,
    "phoneNumber" : this.phoneNumber,
    "is_done": this.isDone == false ? 0 : 1,
  };
}