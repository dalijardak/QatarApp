import "package:flutter/material.dart";
import 'package:qatar_app/screens/user/customerCare.dart';
import 'package:qatar_app/screens/user/home.dart';
import 'package:qatar_app/screens/user/requestList.dart';
import 'package:qatar_app/screens/user/userScreen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: "Home",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return UserScreen(
                      child: HomePage(),
                      title: "Home Page",
                    );
                  }),
                );
              }),
          _createDrawerItem(
            icon: Icons.person,
            text: "Customer Care",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserScreen(
                    child: CustomerCare(),
                    title: "Customer Care",
                  ),
                ),
              );
            },
          ),
          _createDrawerItem(
            icon: Icons.book,
            text: "My Requests",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestList(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("v 0.0.1"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: Stack(
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/logo.png")),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
