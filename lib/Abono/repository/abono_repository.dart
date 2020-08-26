// Project imports:
import 'package:clientmanagerapp/Abono/dao/abonoDao.dart';
import 'package:clientmanagerapp/Abono/model/Abono.dart';

class AbonoRepository {
  final abonoDao = AbonoDao();

  Future getAllAbonos({String query}) => abonoDao.getAbonos(query: query);

  Future<List<Abono>> getAbonosByClientId(int clientId) =>
      abonoDao.getAbonosByClientId(clientId);

  Future insertAbono(Abono abono) => abonoDao.createAbono(abono);

  Future updateAbono(Abono abono) => abonoDao.updateAbono(abono);

  Future deleteAbonoById(int id) => abonoDao.deleteAbono(id);

  //We are not going to use this in the demo
  Future deleteAllAbonos() => abonoDao.deleteAllAbonos();

  Future deleteAllAbonosByClientId(int clientId) =>
      abonoDao.deleteAllAbonosByClientId(clientId);
}
