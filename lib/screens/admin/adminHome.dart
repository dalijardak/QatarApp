import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qatar_app/elements/gridElement.dart';
import 'package:qatar_app/screens/admin/createUser.dart';
import 'package:qatar_app/screens/admin/requestListPage.dart';
import 'package:qatar_app/screens/admin/suggestionListPage.dart';
import 'package:qatar_app/services/authentification.dart';

import 'package:qatar_app/util/size.dart';

class AdminScreen extends StatelessWidget {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(153, 5, 5, 1),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                MaterialCommunityIcons.logout,
              ),
              onPressed: () => _showMyDialog(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Image(
                      image: AssetImage("assets/logo.png"),
                      width: getX(context),
                      height: getY(context) * 0.27,
                    ),
                  ),
                ),
                Container(
                  height: getY(context) * 0.5,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      GridElement(
                        title: "Maintenance Requests",
                        icon: FontAwesomeIcons.tools,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestListView(),
                          ),
                        ),
                      ),
                      GridElement(
                        title: "Create User",
                        icon: Icons.supervised_user_circle,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateUser(),
                          ),
                        ),
                      ),
                      GridElement(
                        title: " Suggestions ",
                        icon: MaterialCommunityIcons.lightbulb_on,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuggestionListView(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
