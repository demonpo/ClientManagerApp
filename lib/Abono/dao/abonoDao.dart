import 'dart:async';

import 'package:clientmanagerapp/Abono/model/Abono.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/database/databaseProvider.dart';
final ABONOTABLE = 'Abono';

class AbonoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createAbono(Abono abono) async {
    final db = await dbProvider.database;
    var result = db.insert(ABONOTABLE, abono.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Abono>> getAbonos({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(ABONOTABLE,
            columns: columns,
            where: 'name LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(ABONOTABLE, columns: columns);
    }

    List<Abono> abonos = result.isNotEmpty
        ? result.map((item) => Abono.fromDatabaseJson(item)).toList()
        : [];
    return abonos;
  }

  Future<List<Abono>> getAbonosByClientId(int clientId) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.rawQuery('SELECT Abono.id, Abono.creation_date, Abono.value, Abono.client_id FROM Abono, Client WHERE Client.id=Abono.client_id');

    List<Abono> abonos = result.isNotEmpty
        ? result.map((item) => Abono.fromDatabaseJson(item)).toList()
        : [];
    return abonos;
  }

  Future deleteAllAbonosByClientId(int clientId) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.rawQuery('DELETE FROM Abono WHERE Abono.client_id=$clientId');

    return result;
  }

  //Update Client record
  Future<int> updateAbono(Abono abono) async {
    final db = await dbProvider.database;

    var result = await db.update(ABONOTABLE, abono.toDatabaseJson(),
        where: "id = ?", whereArgs: [abono.id]);

    return result;
  }

  //Delete Client records
  Future<int> deleteAbono(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(ABONOTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllAbonos() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      ABONOTABLE,
    );

    return result;
  }
}