import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import 'package:qatar_app/util/size.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: getY(context),
              width: getX(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/welcome.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: InkWell(
                child: Container(
                  height: 35,
                  width: getX(context) * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.00),
                    color: Color.fromRGBO(222, 54, 42, 1),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, "/User"),
              ),
              bottom: getY(context) * 0.1,
            ),
            Positioned(
              top: getY(context) * 0.2,
              child: Container(
                height: getY(context) * 0.175,
                width: getX(context) * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Positioned(
              top: getY(context) * 0.45,
              child: Container(
                width: getX(context) * 0.8,
                height: getY(context) * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (!EmailValidator.validate(value)) {
                          return 'Please Enter a valid E-mail address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a Valid Password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
