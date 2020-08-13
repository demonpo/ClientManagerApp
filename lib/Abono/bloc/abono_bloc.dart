


import 'dart:async';

import 'package:clientmanagerapp/Abono/model/Abono.dart';
import 'package:clientmanagerapp/Abono/repository/abono_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AbonoBloc extends Bloc{
  //Get instance of the Repository
  final _abonoRepository = AbonoRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _abonoController = StreamController<List<Abono>>.broadcast();

  get abonos => _abonoController.stream;

  AbonoBloc() {
    getAbonos();
  }

  getAbonos({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    print("GETABONOS");
    _abonoController.sink.add(await _abonoRepository.getAllAbonos(query: query));
  }

  Future<List<Abono>>getAbonosByClientId(int clientId) async{
    //Requiere trabajar en la implementacion, es opcional
    getAbonos();
    return await _abonoRepository.getAbonosByClientId(clientId);
  }

  addAbono(Abono abono) async {
    await _abonoRepository.insertAbono(abono);
    getAbonos();
  }

  updateAbono(Abono abono) async {
    await _abonoRepository.updateClient(abono);
    getAbonos();
  }

  deleteAbonoById(int id) async {
    _abonoRepository.deleteAbonoById(id);
    getAbonos();
  }

  deleteAllAbonosByClientId(int clientId) {
    _abonoRepository.deleteAllAbonosByClientId(clientId);
    getAbonos();
  }


  dispose() {
    print("dispose");
    //_clientController.close();
  }
}