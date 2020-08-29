import "package:flutter/material.dart";
import 'package:qatar_app/elements/gridElement.dart';
import 'package:qatar_app/screens/user/customerCare.dart';
import 'package:qatar_app/screens/user/requestList.dart';

import 'package:qatar_app/screens/user/userScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image(
                image: AssetImage("assets/logo.png"),
                width: 200,
                height: 200,
              ),
            ),
          ),
          Expanded(
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserScreen(
                        child: CustomerCare(),
                        title: "Customer Care",
                      ),
                    ),
                  ),
                ),
                GridElement(
                  title: "Property Search",
                  icon: Icons.search,
                ),
                GridElement(
                  title: "My Requests",
                  icon: Icons.collections,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestList(),
                    ),
                  ),
                ),
                GridElement(
                  title: "Profile",
                  icon: Icons.account_circle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
