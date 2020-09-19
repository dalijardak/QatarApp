import "package:flutter/material.dart";
import 'package:qatar_app/elements/resquest.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qatar_app/screens/user/requestForm.dart';

class RequestList extends StatefulWidget {
  @override
  _RequestListState createState() => _RequestListState();
}

// ignore: unused_element
FirebaseDatabase _database = FirebaseDatabase.instance;

class _RequestListState extends State<RequestList> {
  final dbRef = FirebaseDatabase.instance.reference().child("requests");

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
            if (data != null)
              data.forEach((index, data) => item.add({"key": index, ...data}));
            else
              return Center(
                child: Text(
                  "The List Is Empty",
                  style: TextStyle(fontSize: 40),
                ),
              );
            return ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Request(
                    item[index]["name"].toString(),
                    item[index]["building"].toString(),
                    item[index]["location"].toString(),
                    item[index]["phone"].toString(),
                    item[index]["email"].toString(),
                    item[index]["status"].toString(),
                    item[index]["modified"].toString(),
                    item[index]["description"].toString(),
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
              )),
    );
  }
}
