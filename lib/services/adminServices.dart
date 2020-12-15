import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qatar_app/models/client.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/services/authentification.dart';

Future<dynamic> changeRequestStatus(
    String status, String id, String clientId) async {
  FirebaseDatabase.instance
      .reference()
      .child("requests")
      .child(id)
      .child("status")
      .set(status)
      .whenComplete(() => print("Changed in Requests Table"));
  FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(clientId)
      .child("requests")
      .child(id)
      .child("status")
      .set(status)
      .whenComplete(() => print("Changed in Users Table"));
}

Future<Client> clientInfosId(String clientId) async {
  dynamic result = "";
  await FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(clientId)
      .once()
      .then((snapshot) => result = Client.fromJson(snapshot.value))
      .timeout(Duration(seconds: 10), onTimeout: () => result = null);
  return result;
}

Future<String> deleteSuggestion(String id) async {
  String result = "";
  await FirebaseDatabase.instance
      .reference()
      .child("suggestions")
      .child(id)
      .remove()
      .then((value) => result = "Done")
      .catchError((error) => result = "Error")
      .timeout(Duration(seconds: 5), onTimeout: () => result = "Time Out");
  return result;
}

Future<String> deleteRequest(
    {String clientId, String requestId, String requestImgPath}) async {
  String result = "";
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child('requests/$requestImgPath');
  final requestsTable = FirebaseDatabase.instance.reference().child("requests");
  final adminRequestTable =
      FirebaseDatabase.instance.reference().child("admins");
  final userRequestsTable = FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(clientId)
      .child("requests");
  Auth().checkAdmin().then((value) {
    if (value == "admin") {
      adminRequestTable
          .child(clientId)
          .child("requests")
          .child(requestId)
          .remove();
    }
  });
  await requestsTable
      .child(requestId)
      .remove()
      .then((value) => result = "Done")
      .catchError((error) => result = "Error")
      .timeout(Duration(seconds: 5), onTimeout: () => result = "Time Out");
  await userRequestsTable
      .child(requestId)
      .remove()
      .then((value) => result = "Done")
      .catchError((error) => result = "Error")
      .timeout(Duration(seconds: 5), onTimeout: () => result = "Time Out");
  if (requestImgPath != "N/A") await storageReference.delete();
  return result;
}

Future<String> sendRequestAdmin(Request request) async {
  final requestsTable = FirebaseDatabase.instance.reference().child("requests");
  final adminTable = FirebaseDatabase.instance.reference().child("admins");
  String requestId = requestsTable.push().key;
  String result = "";

  await requestsTable
      .child(requestId)
      .set(
        request.toJson(),
      )
      .then((value) => result = "Done")
      .catchError((test) => result = "Error")
      .timeout(Duration(seconds: 10), onTimeout: () => result = "Timeout");
  await adminTable
      .child(Auth().auth.currentUser.uid)
      .child("requests")
      .child(requestId)
      .set(
        request.toJson(),
      )
      .then((value) => result = "Done")
      .catchError((test) => result = "Error")
      .timeout(Duration(seconds: 10), onTimeout: () => result = "Timeout");
  return result;
}
