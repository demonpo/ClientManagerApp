// Dart imports:
import 'dart:async';

// Package imports:
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

// Project imports:
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Client/repository/client_repository.dart';

class ClientBloc extends Bloc {
  //Get instance of the Repository
  final _clientRepository = ClientRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _clientController = StreamController<List<Client>>.broadcast();

  get clients => _clientController.stream;

  ClientBloc() {
    getClients();
  }

  getClients({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    print("GETCLIENTS");
    _clientController.sink
        .add(await _clientRepository.getAllClients(query: query));
  }

  getAllClients() async {
    return await _clientRepository.getAllClients();
  }

  addClient(Client client) async {
    await _clientRepository.insertClient(client);
    getClients();
  }

  getClientById(int clientId) async {
    await _clientRepository.getClientById(clientId);
  }

  updateClient(Client client) async {
    await _clientRepository.updateClient(client);
    getClients();
  }

  deleteClientById(int id) async {
    _clientRepository.deleteClientById(id);
    getClients();
  }

  dispose() {
    print("dispose");
    //_clientController.close();
  }
}
