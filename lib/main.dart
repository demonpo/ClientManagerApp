import 'dart:async';
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/model/client.dart';
import 'package:clientmanagerapp/Notification/bloc/notification_bloc.dart';
import 'package:clientmanagerapp/Notification/model/Notification.dart' as notif;
import 'package:clientmanagerapp/Notification/utility/notification_helper.dart';
import 'package:clientmanagerapp/client_manager_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workmanager/workmanager.dart';


void callbackDispatcher() {
  final path_database="/assets/db8ArmasPayment.db";
  Workmanager.executeTask((task, inputData) async {
    print("Native called background task");
    switch (task) {
      case "checkDatabase":
        print(" was executed. inputData = $inputData");
        ClientBloc clientBloc;
        NotificationBloc notificationBloc;


        if (await File(await getDatabasesPath()+"$path_database").exists()) {
          clientBloc= ClientBloc();
          notificationBloc = NotificationBloc();
/*
          //Solo para testeo se creara este cliente con deuda
          clientBloc.addClient(Client(
            cedula: "0923040885",
            valorMensual: 40,
            debtValue: 40,
            phoneNumber: "593098",
            birthday: DateTime.now().toString(),
            gender: "macho",
            email: "machoman@gmail.com",
            lastName: "Gibson",
            name: "Mel",
            deadLinePaymentDate: DateTime.now().subtract(Duration(days: 1)).toString(),
            hasDebt: false,
            inscriptionDate: DateTime.now().subtract(Duration(days: 31)).toString(),
            isActive: true,
            photoPath: "",
          ));
          //Solo para testeo se creara este cliente con deuda y listo para renovar
          clientBloc.addClient(Client(
            cedula: "0923040885",
            valorMensual: 40,
            debtValue: -20,
            phoneNumber: "593098",
            birthday: DateTime.now().toString(),
            gender: "macho",
            email: "machoman@gmail.com",
            lastName: "quinquira",
            name: "Chiqui",
            deadLinePaymentDate: DateTime.now().subtract(Duration(days: 1)).toString(),
            hasDebt: false,
            inscriptionDate: DateTime.now().subtract(Duration(days: 31)).toString(),
            isActive: true,
            photoPath: "",
          ));
*/
          List<Client> clients = await clientBloc.getAllClients();
          bool notificationSent = false;
          await clients.forEach(await (Client client) async {
            print("antes del if en el proceso del background");
            if(DateTime.now().isAfter(DateTime.parse(client.deadLinePaymentDate)) && client.debtValue > 0  && client.hasDebt == false && client.isActive){
              print("SE GENERO NOTIFICACION DEL CLIENTE ${client.name} ${client.lastName}");
              client.setAsDebtor();
              clientBloc.updateClient(client);
              await notificationBloc.addNotification(
                await notif.Notification(
                  creationDate: DateTime.now().toString(),
                  clientId: client.id,
                  title: "Deuda!!",
                  details: "El cliente ${client.name} ${client.lastName} tiene una deuda de ${client.debtValue}",
                ),
              );
              if(!notificationSent){
                NotificationHelper().showNotificationBtweenInterval(title: "Deudas!", details: "Hay deudas pendientes!");
                notificationSent = true;
              }

            }
            else if (DateTime.now().isAfter(DateTime.parse(client.deadLinePaymentDate)) && client.debtValue <= 0){
              client.renovarSubscripcion();
              clientBloc.updateClient(client);
            }
          });

          await notificationBloc.getNotifications();
          print("File exists");
        } else {
          print("File don't exists");
        }
        break;
    }
    return Future.value(true);
  });
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //final int helloAlarmID = 0;
  //await AndroidAlarmManager.initialize();
  //await AndroidAlarmManager.periodic(const Duration(seconds: 10), helloAlarmID, printHello, wakeup: true,);
  Workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false// If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager.registerPeriodicTask("1", "checkDatabase",frequency: Duration(minutes: 15),);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "8 Armas Payment",
      theme: ThemeData(
        primaryColor: Color(0xff202225),
        canvasColor: Color(0xffCCD4E0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
  bool isAuthenticated = false;
  bool _canCheckBiometrics;
  final LocalAuthentication auth = LocalAuthentication();
  var prefs;
  String pin;
  BuildContext context2;


  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    context2 = context;
    _checkBiometrics();
    return Scaffold(
      appBar: AppBar(
        title: Text("8 Armas Payment"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff292b2f),
        margin: const EdgeInsets.only(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/"
                      "logo_2.png"),
                ),
              ),
            ),
            Container(margin: const EdgeInsets.only(top: 100.0),
                child:FloatingActionButton.extended(
                  key: Key("btn_ingresar"),
                  onPressed: login,
                  label: Text("Ingresar"),
                  icon: Icon(Icons.fingerprint),
                  backgroundColor: Color(0xff202225),
                )
            )
          ]
        )
      ),
    );
  }




  void login() {
    Workmanager.registerOneOffTask("2", "checkDatabase",);

    if(_canCheckBiometrics) {
      _authenticate();
    } else{
        verifyPin();
    }

  }

  void verifyPin() async {
    prefs = await SharedPreferences.getInstance();
    pin = prefs.getString("pin") ?? "0";
    print("PIN: $pin");
    if(pin=="0") {
      await inputDialog(context2);
    }
    else{
      dialogPin();
    }
  }

void dialogPin(){
  _showLockScreen(
    context2,
    opaque: false,
    cancelButton: Text(
      "Cancelar",
      style: const TextStyle(fontSize: 16, color: Colors.white),
      semanticsLabel: "Cancelar",
    ),
  );
}

  Future<void> inputDialog(BuildContext context){
    String new_pin;
    var isPinValid = false;
    var regExp = RegExp(r"^[0-9]{6}$",);

    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registre su pin de seguridad"),
          content: Row(
            children: <Widget>[
              Expanded(
                  child:TextField(
                    autofocus: true,
                    obscureText: true,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if(regExp.hasMatch(value)){
                        isPinValid= true;
                        new_pin=value;
                      } else {
                        isPinValid = false;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "El pin debe tener 6 dígitos",
                    ),
                  ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Crear PIN"),
              onPressed: () {
                if(isPinValid) {
                  prefs.setString("pin", new_pin);
                  Navigator.pop(context);
                  pin=new_pin;
                  dialogPin();
                }
              },
            ),
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }


 void _showLockScreen(BuildContext context,
      { bool opaque,
        CircleUIConfig circleUIConfig,
        KeyboardUIConfig keyboardUIConfig,
        Widget cancelButton,
        List<String> digits}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
            title: Text(
              "Ingrese código de acceso",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              "Borrar",
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: "Borrar",
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
          ),

        ));
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    var authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Escanea tu huella para autenticarte",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
    });
    if(authenticated){
      await Navigator.push(context2, MaterialPageRoute(builder: (BuildContext context) => ClientManagerMainScreen()));
    }
  }

  void _onPasscodeEntered(String enteredPasscode) {
    isAuthenticated = pin == enteredPasscode;
    _verificationNotifier.add(isAuthenticated);
    if (isAuthenticated) {
      setState(() {
        Navigator.pushReplacement(
          context2,
          MaterialPageRoute(builder: (context) => ClientManagerMainScreen()),
        );
      });
    }
  }

  void _onPasscodeCancelled() {
    Navigator.maybePop(context2);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

}

