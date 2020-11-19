/*import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qatar_app/elements/requestDetails.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RequestView extends StatefulWidget {
  final String name;
  final String building;
  final String location;
  final String phone;
  final String email;
  final String status;
  final String date;
  final String description;
  RequestView({
    this.name,
    this.building,
    this.location,
    this.phone,
    this.email,
    this.status,
    this.date,
    this.description,
  });
  @override
  _RequestViewState createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
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

  Icon _setIcon() {
    switch (this.widget.status) {
      case "Finished":
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 30,
        );
        break;
      case "In Progress":
        return Icon(
          MaterialCommunityIcons.dots_horizontal_circle,
          color: Colors.orange,
          size: 30,
        );
        break;
      case "Pending":
        return Icon(
          MaterialCommunityIcons.dots_horizontal_circle,
          color: Colors.yellow,
          size: 30,
        );
        break;
    }
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
            leading: _setIcon(),
            title: Text(this.widget.name),
            subtitle: Text(this.widget.location),
            trailing: Text(_dateDiff() + " ago"),
            onLongPress: _showMyDialog,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestDetails(
                    name: this.widget.name,
                    building: this.widget.building,
                    location: this.widget.location,
                    phone: this.widget.phone,
                    email: this.widget.email,
                    status: this.widget.status,
                    date: this.widget.date,
                    description: this.widget.description),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

/* clientInfos().then((value) {
        setState(() {
          isLoading = false;
        });
        if (value == null)
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "An Error Has Occurred",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.red,
                  )
                ],
              ),
              backgroundColor: Colors.black,
            ),
          );
      });*/
