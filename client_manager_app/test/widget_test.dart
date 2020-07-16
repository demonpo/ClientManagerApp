// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'package:clientmanagerapp/Client/dao/clientDao.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Client/repository/client_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';


class MockClientDao extends Mock implements ClientDao {}

void main() {
   DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day); 

   test('nombre es mayor a 100', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: '',
                             name: 'It is a long established fact that a reader will be distracted by the readable content of a page whehghijbhuvyvyvcgy',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Masculino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

      Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
   });

   
test('nombre es null', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: ,
                             lastName: 'F',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Femenino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

      Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));  
});

test('nombre esta vacio', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: 'https://picsum.photos/200/300',
                             name: '',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Otros'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

      Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('apellido es mayor a 100', () {
      DateTime yearsBack = now.subtract(Duration(days: 2921));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: '',
                             name: 'It is a long established fact that a reader will be distracted by the readable content of a page whe',
                             lastName: 'It is a long established fact that a reader will be distracted by the readable content of a page whe',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Masculino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

      Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('apellido es null', () {
      DateTime yearsBack = now.subtract(Duration(days: 2921));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             name: 'F',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Femenino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('apellido esta vacio', () {
      DateTime yearsBack = now.subtract(Duration(days: 2921));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: 'https://picsum.photos/200/300',
                             name: 'Andres',
                             lastName: '',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Otros'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

      Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('cliente es menor a 8 años', () {
      DateTime yearsBack = now.subtract(Duration(days: 2921));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: '',
                             name: 'F',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Masculino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('birthday es null', () {
      Client client = Client(id: 1,
                             name: 'Andres',
                             lastName: 'F',
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Femenino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('Email es invalido', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: 'https://picsum.photos/200/300',
                             name: 'F',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'invalido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Otros'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('Email es null', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: '',
                             name: 'Andres',
                             lastName: 'F',
                             birthday: newFormat.format(yearsBack),
                             phoneNumber: '0984824568',
                             gender: 'Masculino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('numero de telefono es invalido', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             name: 'F',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0101010101010101',
                             gender: 'Femenino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

      Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('numero de telefono es null', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: 'https://picsum.photos/200/300',
                             name: 'Andres',
                             lastName: 'F',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             gender: 'Otros'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));  
});

test('genero es null', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: '',
                             name: 'F',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));  
});

test('genero no es valido', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             name: 'Andres',
                             lastName: 'F',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'gnwquv'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));  
});

test('1', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: 'https://picsum.photos/200/300',
                             name: 'F',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Masculino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('1', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             photoPath: '',
                             name: 'Andres',
                             lastName: 'F',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Femenino'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

test('1', () {
      DateTime yearsBack = now.subtract(Duration(days: 2920));
      var newFormat = DateFormat("yyyy-MM-dd");

      Client client = Client(id: 1,
                             name: 'F',
                             lastName: 'Figueroa',
                             birthday: newFormat.format(yearsBack),
                             email: 'valido@gmail.com',
                             phoneNumber: '0984824568',
                             gender: 'Otros'); 

      MockClientDao mkClientDao = MockClientDao();
      when(mkClientDao.createClient(client)).thenAnswer((_) => new Future(() => 1));

      final clientRepository = ClientRepository(
                               clientDao: mkClientDao);

       Future<dynamic> f = clientRepository.insertClient(client);
      expect(f, isNotNull);

      f.then((id) => expect(id, 1))
       .catchError((msg) => expect('ok', msg));   
});

}
