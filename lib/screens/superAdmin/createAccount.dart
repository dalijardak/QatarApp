import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';

import 'package:qatar_app/elements/gridElement.dart';
import 'package:qatar_app/screens/admin/createUser.dart';

import 'package:qatar_app/screens/superAdmin/createAdmin.dart';
import 'package:qatar_app/services/authentification.dart';

import 'package:qatar_app/util/size.dart';

class CreateAccount extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              MaterialCommunityIcons.logout,
            ),
            onPressed: () => _showMyDialog(context),
          )
        ],
      ),
      body: Container(
        height: getY(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                  ),
                ),
              ),
            ),
            Container(
                child: Container(
              height: getY(context) * 0.55,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  GridElement(
                    title: "Create User ",
                    icon: Icons.person_add,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateUser(),
                      ),
                    ),
                  ),
                  GridElement(
                    title: "Create Admin ",
                    icon: Icons.supervised_user_circle,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAdmin(),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
