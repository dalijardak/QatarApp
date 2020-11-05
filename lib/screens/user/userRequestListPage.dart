import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/screens/user/requestForm.dart';
import 'package:qatar_app/services/authentification.dart';
import 'package:qatar_app/view/userRequestView.dart';

class UserRequestListView extends StatefulWidget {
  @override
  _UserRequestListViewState createState() => _UserRequestListViewState();
}

// ignore: unused_element
FirebaseDatabase _database = FirebaseDatabase.instance;

class _UserRequestListViewState extends State<UserRequestListView> {
  final dbRef = FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(Auth().auth.currentUser.uid)
      .child("requests");

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text("My Requests"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snap) {
          if (!snap.hasData)
            return Center(
              child: SizedBox(
                height: 70,
                width: 70,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            );
          else {
            Map data = snap.data.snapshot.value;
            List item = [];
            if (data != null) {
              data.forEach((index, data) => item.add({"key": index, ...data}));
            } else
              return Center(
                child: Text(
                  "The List Is Empty",
                  style: TextStyle(fontSize: 40),
                ),
              );
            return ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return UserRequestView(
                    request: Request.fromJson(item[index]),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddRequest(),
          ),
        ),
      ),
    );
  }
}
