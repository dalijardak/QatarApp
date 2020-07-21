import "package:flutter/material.dart";

class Home extends StatelessWidget {
  @override
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage("assets/logo.png"),
          width: 200,
          height: 200,
        )
      ],
    ));
  }
}
