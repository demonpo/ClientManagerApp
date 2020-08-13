import 'dart:async';

import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/database/databaseProvider.dart';


class ClientDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createClient(Client client) async {
    final db = await dbProvider.database;
    var result = db.insert(clientTABLE, client.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Client>> getClients({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(clientTABLE,
            columns: columns,
            where: 'name LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(clientTABLE, columns: columns);
    }

    List<Client> clients = result.isNotEmpty
        ? result.map((item) => Client.fromDatabaseJson(item)).toList()
        : [];
    return clients;
  }

  //Update Client record
  Future<int> updateClient(Client client) async {
    final db = await dbProvider.database;

    var result = await db.update(clientTABLE, client.toDatabaseJson(),
        where: "id = ?", whereArgs: [client.id]);

    return result;
  }

  //Delete Client records
  Future<int> deleteClient(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(clientTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllClients() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      clientTABLE,
    );

    return result;
  }
}