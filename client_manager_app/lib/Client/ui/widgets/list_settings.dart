import 'package:flutter/material.dart';
import 'package:clientmanagerapp/database/databaseUpload.dart';


class ListSettings extends StatelessWidget {
  DatabaseUpload databaseUpload= new DatabaseUpload();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Configuraciones"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.storage),
              title: Text('Vincular con Google Drive'),
                onTap: () {
                  databaseUpload.loginGoogle();

                }
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text('Subir Backup'),
                onTap: () {
                  databaseUpload.uploadFiles();
                 showAlertDialog(context,"Backup Subido","Su base de datos se encuentra respaldada en Google Drive");
                }
            ),
            ListTile(
              leading: Icon(Icons.cloud_download),
              title: Text('Descargar Backup'),
                onTap: () {
                  databaseUpload.downloadFiles();
                  showAlertDialog(context,"Backup Descargado","Su base de datos se descargó con exito");
                }
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Desvincular Cuenta de Google'),
                onTap: () {
                  databaseUpload.logoutGoogle();
                  showAlertDialog(context,"Cuenta Desvinculada","Su cuenta de Google ya no se encuentra vinculada con la aplicación");
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