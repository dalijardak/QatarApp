import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qatar_app/elements/gridElement.dart';
import 'package:qatar_app/screens/user/userRequestListPage.dart';
import 'package:qatar_app/services/authentification.dart';

import 'package:qatar_app/util/size.dart';

import '../contact_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(153, 5, 5, 1),
          title: Text("Home"),
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
        body: Container(
          height: getY(context),
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
                      title: "Customer Care",
                      icon: Icons.person,
                      onTap: () =>
                          Navigator.pushNamed(context, '/Customer_Care'),
                    ),
                    GridElement(
                      title: "My Requests",
                      icon: Icons.collections,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserRequestListView(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          child: BottomAppBar(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Color.fromRGBO(153, 5, 5, 1),
              ),
              height: getY(context) * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Georgia",
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Contact(),
            ),
          ),
        ),
      ),
    );
  }
}
