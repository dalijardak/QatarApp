import "package:flutter/material.dart";
import 'package:qatar_app/services/authentification.dart';
import 'package:qatar_app/util/size.dart';

class WelcomePage extends StatelessWidget {
  final Auth auth = new Auth();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: getY(context),
          width: getX(context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/welcome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: getY(context) * 0.1,
                child: Container(
                  height: getY(context) * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.00),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Color.fromRGBO(222, 54, 42, 1),
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, "/Login"),
                      ),
                      Text(
                        "Not Registred ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.00),
                            color: Color.fromRGBO(222, 54, 42, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Contact us to register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, "/Contact"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
