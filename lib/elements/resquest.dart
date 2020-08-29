import "package:flutter/material.dart";
import 'package:qatar_app/elements/requestDetails.dart';
import 'package:firebase_database/firebase_database.dart';

class Request extends StatefulWidget {
  String name;
  String building;
  String location;
  String phone;
  String email;
  String status;
  String date;
  String description;
  Request(String name, String building, String location, String phone,
      String email, String status, String date, String description) {
    this.name = name;
    this.building = building;
    this.location = location;
    this.phone = phone;
    this.email = email;
    this.status = status;
    this.date = date;
    this.description = description;
  }

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  _dateDiff() {
    var dateNow = new DateTime.now();
    var dateThen = DateTime.parse(this.widget.date);
    var duration = dateNow.difference(dateThen);
    if (duration.inSeconds < 60)
      return duration.inSeconds.toString() + " seconds ";
    else if (duration.inMinutes < 60)
      return duration.inMinutes.toString() + " minutes";
    else if (duration.inHours < 24)
      return duration.inHours.toString() + " hours";
    else if (duration.inDays < 30)
      return duration.inDays.toString() + " days";
    else
      return ((duration.inDays ~/ 30).toString() + " month");
  }

  Color _setColor() {
    if (this.widget.status == "Finished")
      return Colors.green;
    else
      return Colors.yellow;
  }

  _deleteRequest() {
    FirebaseDatabase.instance
        .reference()
        .child("requests")
        .orderByChild("name")
        .equalTo(this.widget.name)
        .onChildAdded
        .listen((Event event) {
      FirebaseDatabase.instance
          .reference()
          .child('requests')
          .child(event.snapshot.key)
          .remove();
    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this request ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                _deleteRequest();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: SizedBox(
              width: 20.0,
              height: 70.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _setColor(),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            title: Text(this.widget.name),
            subtitle: Text(this.widget.location),
            trailing: Text(_dateDiff() + " ago"),
            onLongPress: _showMyDialog,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestDetails(
                    this.widget.name,
                    this.widget.building,
                    this.widget.location,
                    this.widget.phone,
                    this.widget.email,
                    this.widget.status,
                    this.widget.date,
                    this.widget.description),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
