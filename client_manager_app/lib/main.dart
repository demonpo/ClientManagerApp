import 'dart:async';
import 'package:clientmanagerapp/client_manager_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';


void main() {
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
      title: '8 Armas Payment',
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




  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage('assets/icons/'
                      'logo_2.png'),
                ),
              ),
            ),
            Container(margin: const EdgeInsets.only(top: 100.0),
                child:FloatingActionButton.extended(
                  onPressed: login,
                  label: Text('Ingresar'),
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
  if(_canCheckBiometrics) _authenticate();
  else{
    _showLockScreen(
      context,
      opaque: false,
      cancelButton: Text(
        'Cancelar',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancelar',
      ),
    );
  }
  }

  _showLockScreen(BuildContext context,
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
              'Ingrese código de acceso',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Borrar',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Borrar',
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
    bool authenticated = false;
    String _authorized = 'No Autorizado';
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Escanea tu huella para autenticarte',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Autorizado' : 'No Autorizado';
    setState(() {
      _authorized = message;
    });
    if(authenticated){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ClientManagerMainScreen()));
    }
  }

  _onPasscodeEntered(String enteredPasscode) {
    isAuthenticated = '123456' == enteredPasscode;
    _verificationNotifier.add(isAuthenticated);
    if (isAuthenticated) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ClientManagerMainScreen()),
        );
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

}

