import 'package:flutter/material.dart';
import 'package:clientmanagerapp/database/databaseUpload.dart';
import 'package:progress_dialog/progress_dialog.dart';


class ListSettings extends StatelessWidget {
  ProgressDialog pr;
  DatabaseUpload databaseUpload= new DatabaseUpload();
  @override
  Widget build(BuildContext context) {

    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
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
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.storage),
              title: Text('Vincular con Google Drive'),
                onTap: () async {
                if(!await databaseUpload.isSignedIn()){
                  pr.show();
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    pr.hide().whenComplete(() {
                      databaseUpload.loginGoogle();
                    });
                  });
                }
                else{
                  showAlertDialog(context,"Cuenta vinculada","Su cuenta ya se encuentra vinculada");
                }
                }
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text('Subir Backup'),
                onTap: () async {
            if(!await databaseUpload.isSignedIn()){
              showAlertDialog(context,"Accion requerida","Debe vincular una cuenta de Google Drive");
                  }
            else{
                 databaseUpload.uploadFiles();
                 pr.show();
                 Future.delayed(Duration(seconds: 3)).then((value) {
                   pr.hide().whenComplete(() {
                     showAlertDialog(context,"Backup Subido","Su base de datos se encuentra respaldada en Google Drive");
                   });
                 });
                }}
            ),
            ListTile(
              leading: Icon(Icons.cloud_download),
              title: Text('Descargar Backup'),
                onTap: () async {
                  if (!await databaseUpload.isSignedIn ()){
                  showAlertDialog(context,"Accion requerida","Debe vincular una cuenta de Google Drive");
                  }else{
                  databaseUpload.downloadFiles();
                  pr.show();
                  Future.delayed(Duration(seconds: 3)).then((value) {
                  pr.hide().whenComplete(() {
                  showAlertDialog(context,"Backup Descargado","Su base de datos se descargó con exito");
                  });
                  });
                  }
                }
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Desvincular Cuenta de Google'),
                onTap: () {
                  databaseUpload.logoutGoogle();
                  pr.show();
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    pr.hide().whenComplete(() {
                      showAlertDialog(context,"Cuenta Desvinculada","Su cuenta de Google ya no se encuentra vinculada con la aplicación");
                    });
                  });
                }
            ),
            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Errores'),
            ),
          ],
        )
    );
  }

  showAlertDialog(BuildContext context,String title, String message) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.maybePop(context);},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}