import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/screens/admin/requestForm.dart';
import 'package:qatar_app/screens/admin/requestView.dart';
import 'package:qatar_app/services/authentification.dart';

class AdminRequestListView extends StatefulWidget {
  @override
  _AdminRequestListViewState createState() => _AdminRequestListViewState();
}

// ignore: unused_element
FirebaseDatabase _database = FirebaseDatabase.instance;

class _AdminRequestListViewState extends State<AdminRequestListView> {
  final dbRef = FirebaseDatabase.instance
      .reference()
      .child("admins")
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
              item.sort((b, a) => a["date"].compareTo(b["date"]));
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
                  return RequestView(
                    requestId: item[index]["key"],
                    request: Request.fromJson(item[index]),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddRequestAdmin(),
          ),
        ),
      ),
    );
  }
}
