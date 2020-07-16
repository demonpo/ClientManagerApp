


import 'package:clientmanagerapp/Client/dao/clientDao.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';


class ClientRepository {
  ClientDao clientDao;

  ClientRepository({ClientDao clientDao}){
    if(clientDao == null){ 
      this.clientDao = ClientDao(); 
      print("new");
    }else{
      print("passed");
      this.clientDao = clientDao;
    }
  }

  Future getAllClients({String query}) { 
    //validations
    return clientDao.getClients(query: query);   
  } 

  Future insertClient(Client client) {
    String validator = clientValidator(client);
    print(validator);
    if(validator.contains('ok')){
       return clientDao.createClient(client);
    }
    return new Future.error(validator);
  } 

  Future updateClient(Client client) {
    //validations
    return clientDao.updateClient(client);
  }

  Future deleteClientById(int id) { 
    //validations
    return clientDao.deleteClient(id); 
  }

  
  String clientValidator(Client client){
    //name
    if(client.name == null ) return 'El nombre del cliente es nulo'; 
    if(client.name.isEmpty ) return 'El nombre del cliente esta vacio';
    if(client.name.length > 100 ) return 'El nombre del cliente es mayor a 100 caracteres';

    //apellido
    if(client.lastName == null ) return 'El apellido del cliente es nulo'; 
    if(client.lastName.isEmpty ) return 'El apellido del cliente esta vacio';
    if(client.lastName.length > 100) return 'El apellido del cliente es mayor a 100 caracteres';
    
    //birthday
    if(client.birthday == null) return 'la fecha de nacimiento del cliente es nulo'; 
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day); 
    DateTime minAge = now.subtract(Duration(days: 2920));
    DateTime birthday = new DateFormat("yyyy-MM-dd").parse(client.birthday);
    if(birthday.isAfter(minAge))return 'el cliente es menor a 8 años';
    
    if(client.email == null)  return 'El email es nulo';
    if(!EmailValidator.validate(client.email)) return 'El email es invalido';

    if(client.email == null)  return 'El Número de telefono es nulo';
    if(client.phoneNumber.length <= 9 && client.phoneNumber.length >= 15) return 'El Numero de teléfono es invalido';
    
    if(client.gender == null)  return 'El genero es nulo';
    if(client.gender != 'Masculino' && 
       client.gender != 'Femenino' && 
       client.gender != 'Otros')  return 'El género no es válido';
    
    return 'ok';
  }

  String validId(int id){
    if(id == 0) return 'El id es cero';
    if(id < 0 ) return 'El id es negativo';
    return 'ok';
  }
   
  //We are not going to use this in the demo
  Future deleteAllClients() => clientDao.deleteAllClients();
}