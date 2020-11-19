import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:qatar_app/models/suggestion.dart';
import 'package:qatar_app/view/suggestionView.dart';

class SuggestionListView extends StatefulWidget {
  @override
  _SuggestionListViewState createState() => _SuggestionListViewState();
}

// ignore: unused_element
FirebaseDatabase _database = FirebaseDatabase.instance;

class _SuggestionListViewState extends State<SuggestionListView> {
  final dbRef = FirebaseDatabase.instance.reference().child("suggestions");

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text("Suggestions"),
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
                  return SuggestionView(
                    suggestion: Suggestion.fromJson(
                      item[index],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
