import 'package:firebase_database/firebase_database.dart';
import 'package:qatar_app/models/client.dart';

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
