
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<http.Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}

class DatabaseUpload {
  final storage = new FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
  GoogleSignIn(scopes: [ga.DriveApi.DriveAppdataScope]);
  GoogleSignInAccount googleSignInAccount;
  ga.FileList list;
  var signedIn = false;

  void loginGoogle(){
    _loginWithGoogle();
  }

  void uploadFiles(){
    _uploadFileToGoogleDrive();
  }


  void downloadFiles(){
    _listGoogleDriveFiles();
  }

  void logoutGoogle(){
    _logoutFromGoogle();
  }

  Future<bool> isSignedIn() async {
    signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
    print("LOGIN:  ${signedIn}");
    return signedIn;
  }

  Future<void> _loginWithGoogle() async {
    signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount googleSignInAccount) async {
      if (googleSignInAccount != null) {
        _afterGoogleLogin(googleSignInAccount);
      }
    });
    if (signedIn) {
      try {
        googleSignIn.signInSilently(suppressErrors: false).whenComplete(() => () {});
      } catch (e) {
        storage.write(key: "signedIn", value: "false").then((value) {
            signedIn = false;
        });
      }
    } else {
      final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signIn();
      _afterGoogleLogin(googleSignInAccount);
    }
  }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    googleSignInAccount = gSA;
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');
    storage.write(key: "signedIn", value: "true").then((value) {
    signedIn = true;
    });

  }

  void _logoutFromGoogle() async {
    googleSignIn.signOut().then((value) {
      print("User Sign Out");
      storage.write(key: "signedIn", value: "false").then((value) {
          signedIn = false;
      });
    });
  }


  _uploadFileToGoogleDrive() async {
    await _loginWithGoogle();
    await Future.delayed(Duration(seconds: 3));
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    print("Uploading file");
    ga.File fileToUpload = ga.File();
    File file = await _localFile;
    fileToUpload.parents = ["appDataFolder"];
    fileToUpload.name = "db8ArmasPayment.db";
    var response = await drive.files.create(
      fileToUpload,
      uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
    );
    print("Result ${response.toJson()}");

  }

  Future<File> get _localFile async {
    String databasePath = await getDatabasesPath();
    return File('$databasePath/assets/db8ArmasPayment.db');
  }

  Future<void> _downloadGoogleDriveFile(String fName, String gdID) async {
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    ga.Media file = await drive.files
        .get(gdID, downloadOptions: ga.DownloadOptions.FullMedia);
    print(file.stream);

    final directory = await getExternalStorageDirectory();
    print(directory.path);
    final saveFile = File('${directory.path}/$fName');
    List<int> dataStore = [];
    file.stream.listen((data) {
      print("DataReceived: ${data.length}");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () {
      print("Task Done");
      saveFile.writeAsBytes(dataStore);
      print("File saved at ${saveFile.path}");
    }, onError: (error) {
      print("Some Error");
    });
  }

  Future<void> _listGoogleDriveFiles() async {
    await _loginWithGoogle();
    await Future.delayed(Duration(seconds: 3));
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    drive.files.list(spaces: 'appDataFolder').then((value) {
          list = value;
          print("Id: ${list.files[0].id} File Name:${list.files[0].name}");
        _downloadGoogleDriveFile(list.files[0].name, list.files[0].id);
    });
  }

}