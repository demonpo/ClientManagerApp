


import 'package:clientmanagerapp/Client/dao/clientDao.dart';
import 'package:clientmanagerapp/Client/model/client.dart';

class ClientRepository {
  final clientDao = ClientDao();

  Future getAllClients({String query}) => clientDao.getClients(query: query);

  Future insertClient(Client client) => clientDao.createClient(client);

  Future updateClient(Client client) => clientDao.updateClient(client);

  Future deleteClientById(int id) => clientDao.deleteClient(id);

  //We are not going to use this in the demo
  Future deleteAllClients() => clientDao.deleteAllClients();
}