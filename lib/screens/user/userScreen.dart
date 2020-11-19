import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qatar_app/services/authentification.dart';

class UserScreen extends StatelessWidget {
  final Widget child;
  final String title;
  UserScreen({Key key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Log Out'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Confirm ?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Auth().signOut().then(
                        (value) => Navigator.pushNamed(context, "/"),
                      );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text("${this.title}"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.pushNamed(context, "/Profile"),
        ),
        actions: [
          IconButton(
            icon: Icon(
              MaterialCommunityIcons.logout,
            ),
            onPressed: () => _showMyDialog(context),
          )
        ],
      ),
      body: this.child,
    );
  }
}
