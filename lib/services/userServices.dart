import 'package:firebase_database/firebase_database.dart';
import 'package:qatar_app/models/client.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/models/suggestion.dart';
import 'package:qatar_app/services/authentification.dart';

Future<String> sendRequest(Request request) async {
  final requestsTable = FirebaseDatabase.instance.reference().child("requests");

  final userRequests = FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(Auth().auth.currentUser.uid)
      .child("requests");
  String requestId = userRequests.push().key;
  String result = "";
  await userRequests.child(requestId).set(
        request.myRequesttoJson(),
      );

  await requestsTable
      .child(requestId)
      .set(
        request.toJson(),
      )
      .then((value) => result = "Done")
      .catchError((test) => result = "Error")
      .timeout(Duration(seconds: 10), onTimeout: () => result = "Timeout");
  return result;
}

// ignore: missing_return
Future<String> sendSuggestion(Suggestion suggestion) async {
  final suggestionTable =
      FirebaseDatabase.instance.reference().child("suggestions");
  String suggestionId = suggestionTable.push().key;
  String result = "";
  await suggestionTable
      .child(suggestionId)
      .set(suggestion.toJson())
      .then((value) => result = "Done")
      .catchError((test) => result = "Error")
      .timeout(Duration(seconds: 10), onTimeout: () => result = "Timeout");
  return result;
}

Future<Client> clientInfos() async {
  dynamic result = "";
  await FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(Auth().auth.currentUser.uid)
      .once()
      .then((snapshot) => result = Client.fromJson(snapshot.value))
      .timeout(Duration(seconds: 10), onTimeout: () => result = null);
  return result;
}

Future<List<Request>> requestList() async {
  List<Request> myRequests = [];
  final response = (await FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(Auth().auth.currentUser.uid)
          .child("requests")
          .once())
      .value;
  Map<dynamic, dynamic> values = response;
  values.forEach((key, values) {
    myRequests.add(Request.fromJson(values));
  });

  return myRequests;
}
