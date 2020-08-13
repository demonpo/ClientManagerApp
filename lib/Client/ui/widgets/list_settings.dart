import 'package:flutter/material.dart';
import 'package:clientmanagerapp/database/databaseUpload.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListSettings extends StatelessWidget {
  ProgressDialog pr;
  var cancel=false;
  DatabaseUpload databaseUpload= DatabaseUpload();
  @override
  Widget build(BuildContext context) {

    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );

    pr.style(
      message:
      "Espere un momento ...",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
    );


    return Scaffold(
        appBar: AppBar(
          title: Text("Configuraciones"),
        ),
        body: Container(
            color: Color(0xff292b2f),
            child:
            ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.storage,color:Colors.white),
              title: const Text("Vincular con Google Drive", style: TextStyle(
                  color: Colors.white
              )),
                onTap: () async {
                if(!await databaseUpload.isSignedIn()){
                  await pr.show();
                  await databaseUpload.loginGoogle();
                  showAlertDialog(context,"Cuenta vinculada","Su cuenta se vinculó con éxito");
                }
                else{
                  showAlertDialog(context,"Cuenta vinculada","Su cuenta ya se encuentra vinculada");
                }
                }
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload,color:Colors.white),
              title: const Text("Subir Backup", style: TextStyle(
                  color: Colors.white
              )),
                onTap: () async {
            if(!await databaseUpload.isSignedIn()){
              showAlertDialog(context,"Accion requerida","Debe vincular una cuenta de Google Drive");
                  }
            else{
              await pr.show();
                 await databaseUpload.uploadFiles();
              showAlertDialog(context,"Backup Subido","Su base de datos se encuentra respaldada en Google Drive");
                }}
            ),
            ListTile(
              leading: Icon(Icons.cloud_download,color:Colors.white),
              title: const Text("Descargar Backup", style: TextStyle(
                  color: Colors.white
              )),
                onTap: () async {
                  if (!await databaseUpload.isSignedIn ()){
                  showAlertDialog(context,"Accion requerida","Debe vincular una cuenta de Google Drive");
                  }else{
                    await pr.show();
                  await databaseUpload.downloadFiles();
                  showAlertDialog(context,"Backup Descargado","Su base de datos se descargó con exito");
                  }
                }
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,color:Colors.white),
              title: const Text("Desvincular cuenta de Google", style: TextStyle(
                  color: Colors.white
              )),
                onTap: () async {
                  await pr.show();
                  await databaseUpload.logoutGoogle();
                  showAlertDialog(context,"Cuenta Desvinculada","Su cuenta de Google ya no se encuentra vinculada con la aplicación");
                }
            ),
            ListTile(
              leading: Icon(Icons.security,color:Colors.white),
              title: const Text("Cambiar Pin", style: TextStyle(
                  color: Colors.white
              )),
                onTap: () async {
                  await inputDialog(context);
                  if(!cancel) {
                    showAlertDialog(context, "Nuevo Pin establecido",
                        "A partir de ahora el ingreso a la aplicación será con el nuevo Pin");
                  }

                }
            ),
          ],
        )
    ));
  }

  void showAlertDialog(BuildContext context,String title, String message) {
    pr.hide();
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.maybePop(context);},
    );

    // set up the AlertDialog
    var alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
        barrierDismissible: false,

      builder: (BuildContext context) {
        return alert;
      },
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
              onPressed: () async {
                if(isPinValid) {
                  cancel=false;
                  var prefs = await SharedPreferences.getInstance();
                  await prefs.setString("pin", new_pin);
                  Navigator.pop(context);
                }
              },
            ),
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                cancel=true;
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

}