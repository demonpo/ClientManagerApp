// Dart imports:
import 'dart:async';

// Package imports:
import 'package:sqflite/sqflite.dart';

final clientTABLE = 'Client';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;
  final path_database = "/assets/db8ArmasPayment.db";
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    var database = await openDatabase(
        await getDatabasesPath() + "$path_database",
        version: 2,
        onCreate: initDB,
        onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $clientTABLE ("
        "id INTEGER PRIMARY KEY, "
        "cedula TEXT, "
        "name TEXT, "
        "photoPath TEXT, "
        "lastName TEXT, "
        "birthday TEXT, "
        "email TEXT, "
        "phoneNumber TEXT, "
        "gender TEXT, "
        /*SQLITE doesn't have boolean type
        so we store isDone as integer where 0 is false
        and 1 is true*/
        "is_active INTEGER, "
        "inscription_date TEXT, "
        "has_debt integer, "
        "debt_value real, "
        "deadline_payment_date TEXT, "
        "valor_mensual real "
        ");");

    await database.execute("CREATE TABLE Abono ("
        "id INTEGER PRIMARY KEY, "
        "creation_date TEXT, "
        "value real, "
        "client_id INTEGER, "
        "CONSTRAINT fk_Client_Abono FOREIGN KEY (client_id) REFERENCES Client (id)"
        ");");

    await database.execute("CREATE TABLE Notification ("
        "id INTEGER PRIMARY KEY, "
        "creationDate TEXT, "
        "title TEXT, "
        "details TEXT, "
        "client_id INTEGER, "
        "CONSTRAINT fk_Client_Notification FOREIGN KEY (client_id) REFERENCES Client (id)"
        ");");
  }
}
