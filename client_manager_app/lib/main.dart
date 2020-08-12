import "dart:async";
import "package:shared_preferences/shared_preferences.dart";
import 'package:background_fetch/background_fetch.dart';
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/client_manager_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:local_auth/local_auth.dart";
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

final DATABASE_NAME="ReactiveClientManager2-3.db";

void backgroundFetchHeadlessTask(String taskId) async {
  print("[BackgroundFetch] Headless event received: $taskId");
  ClientBloc clientBloc;
  var documentsDirectory = await getApplicationDocumentsDirectory();
  var path = join(documentsDirectory.path, DATABASE_NAME);

  if (await File(path).exists()) {
    clientBloc= ClientBloc();
    print("File exists");
  } else {
    print("File don't exists");
  }

  BackgroundFetch.finish(taskId);

}

void main() {
  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
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
    initPlatformState();
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

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    await BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      forceAlarmManager: false,
      stopOnTerminate: false,
      startOnBoot: true,
      enableHeadless: true,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.NONE,
    ), _onBackgroundFetch).then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });


  }

  void _onBackgroundFetch(String taskId) async {

    // This is the fetch-event callback.
    print("[BackgroundFetch] Event received: $taskId");
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, DATABASE_NAME);

    if (await File(path).exists()) {
      print("File exists");
    } else {
      print("File don't exists");
    }




    if (taskId == "flutter_background_fetch") {
      // Schedule a one-shot task when fetch event received (for testing).
      await BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.transistorsoft.customtask",
          delay: 5000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true
      ));
    }

    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }

  void login() {

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

