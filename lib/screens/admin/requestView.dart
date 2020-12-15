import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/screens/admin/requestDetails.dart';
import 'package:qatar_app/services/adminServices.dart';

class RequestView extends StatefulWidget {
  final Request request;
  final String requestId;
  RequestView({this.request, this.requestId});
  @override
  _RequestViewState createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  _dateDiff() {
    var dateNow = new DateTime.now();
    var dateThen = DateTime.parse(this.widget.request.date);
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

  // ignore: missing_return
  Icon _setIcon() {
    switch (this.widget.request.status) {
      case "Finished":
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 30,
        );
        break;
      case "In Progress":
        return Icon(
          MaterialCommunityIcons.progress_clock,
          color: Colors.yellow,
          size: 30,
        );
        break;
      case "Pending":
        return Icon(
          MaterialCommunityIcons.dots_horizontal_circle,
          color: Colors.orange,
          size: 30,
        );
        break;
    }
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
                deleteRequest(
                  clientId: this.widget.request.clientId,
                  requestId: this.widget.requestId,
                  requestImgPath: this.widget.request.imgPath,
                ).then((value) => print(value));
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
            title: Text(this.widget.request.subject),
            subtitle: Text(this.widget.request.location),
            trailing: Text(_dateDiff() + " ago"),
            onLongPress: _showMyDialog,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestDetails(
                  request: this.widget.request,
                  requestId: this.widget.requestId,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
