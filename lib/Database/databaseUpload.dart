// Dart imports:
import 'dart:io';

// Package imports:
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:googleapis/drive/v3.dart" as ga;
import "package:http/http.dart" as http;
import "package:http/io_client.dart";
import "package:sqflite/sqflite.dart";

class GoogleHttpClient extends IOClient {
  final Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<http.Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}

class DatabaseUpload {
  final storage = FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
      GoogleSignIn(scopes: [ga.DriveApi.DriveAppdataScope]);
  GoogleSignInAccount googleSignInAccount;
  ga.FileList list;
  var signedIn = false;
  var cancel_login = false;

  Future<void> loginGoogle() async {
    await _loginWithGoogle();
  }

  Future<void> uploadFiles() async {
    await _uploadFileToGoogleDrive();
  }

  Future<void> downloadFiles() async {
    await _listGoogleDriveFiles();
  }

  Future<void> logoutGoogle() async {
    await _logoutFromGoogle();
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
        await _afterGoogleLogin(googleSignInAccount);
      }
    });
    if (signedIn) {
      try {
        await googleSignIn
            .signInSilently(suppressErrors: false)
            .whenComplete(() => () {});
      } catch (e) {
        await storage.write(key: "signedIn", value: "false").then((value) {
          signedIn = false;
        });
      }
    } else {
      var googleSignInAccount = await googleSignIn.signIn();
      await _afterGoogleLogin(googleSignInAccount);
    }
  }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    try {
      googleSignInAccount = gSA;
      var googleSignInAuthentication = await googleSignInAccount.authentication;
      var credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await _auth.signInWithCredential(credential);

      var user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      var currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      print("signInWithGoogle succeeded: $user");
      await storage.write(key: "signedIn", value: "true").then((value) {
        signedIn = true;
      });
    } catch (e) {
      cancel_login = true;
    }
  }

  Future<void> _logoutFromGoogle() async {
    await googleSignIn.signOut().then((value) {
      print("User Sign Out");
      storage.write(key: "signedIn", value: "false").then((value) {
        signedIn = false;
      });
    });
  }

  Future<void> _uploadFileToGoogleDrive() async {
    await _loginWithGoogle();
    await Future.delayed(Duration(seconds: 3));
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    print("Uploading file");
    var fileToUpload = ga.File();
    var file = await _localFile;
    fileToUpload.parents = ["appDataFolder"];
    fileToUpload.name = "db8ArmasPayment.db";
    var response = await drive.files.create(
      fileToUpload,
      uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
    );
    print("Result ${response.toJson()}");
  }

  Future<File> get _localFile async {
    var databasePath = await getDatabasesPath();
    print("$databasePath/assets/db8ArmasPayment.db");
    return File("$databasePath/assets/db8ArmasPayment.db");
  }

  Future<void> _downloadGoogleDriveFile(String fName, String gdID) async {
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    ga.Media file = await drive.files
        .get(gdID, downloadOptions: ga.DownloadOptions.FullMedia);
    print(file.stream);

    final saveFile = File("${await getDatabasesPath() + "/assets"}/$fName");
    var dataStore = <int>[];
    file.stream.listen((data) {
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () {
      saveFile.writeAsBytes(dataStore);
      print("File saved at ${saveFile.path}");
    }, onError: (error) {});
  }

  Future<void> _listGoogleDriveFiles() async {
    await _loginWithGoogle();
    await Future.delayed(Duration(seconds: 3));
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    await drive.files.list(spaces: "appDataFolder").then((value) {
      try {
        list = value;
        print("Id: ${list.files[0].id} File Name:${list.files[0].name}");
        _downloadGoogleDriveFile(list.files[0].name, list.files[0].id);
      } catch (e) {
        list = null;
      }
    });
  }
}
