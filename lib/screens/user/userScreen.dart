import 'package:flutter/material.dart';
import 'package:qatar_app/elements/myDrawer.dart';
import 'package:qatar_app/screens/contact_page.dart';

class UserScreen extends StatelessWidget {
  final Widget child;
  final String title;
  UserScreen({Key key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text("${this.title}"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: this.child,
      bottomNavigationBar: InkWell(
        child: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Color.fromRGBO(153, 5, 5, 1),
            ),
            height: 75,
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
    );
  }
}
