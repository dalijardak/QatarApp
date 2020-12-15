import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import 'package:qatar_app/services/authentification.dart';
import 'package:qatar_app/util/size.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool isLoading = false;
  bool error = false;
  String errorMsg = "";

  _validate(BuildContext context) {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Auth().singIn(emailController.text, passwordController.text).then(
        (value) {
          if (value == "ok") {
            Auth().checkAdmin().then((value) {
              print(value);
              if (value == "superAdmin")
                Navigator.pushNamed(context, "/SuperAdmin");
              else if (value == "admin")
                Navigator.pushNamed(context, "/Admin");
              else
                Navigator.pushNamed(context, "/User");
            });
          } else if (value == "No user found for that email" ||
              value == "Wrong password provided for that user") {
            setState(() {
              isLoading = false;
              errorMsg = "Wrong email or password";
              error = true;
            });
          } else if (value == "Too many login attempts") {
            setState(() {
              isLoading = false;
              errorMsg = "Too many login attempts\ntry again in 1 minute";
              error = true;
            });
          }
        },
      );
      //Auth().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : RaisedButton(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),
                          child: Container(
                            width: getX(context) * 0.3,
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => _validate(context),
                        ),
                ),
                bottom: getY(context) * 0.1,
              ),
              Positioned(
                child: error
                    ? Text(
                        errorMsg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      )
                    : SizedBox(),
                bottom: getY(context) * 0.18,
              ),
              Positioned(
                top: getY(context) * 0.45,
                child: Container(
                  width: getX(context) * 0.8,
                  height: getY(context) * 0.35,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: emailController,
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
                          obscureText: true,
                          controller: passwordController,
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
                              Icons.lock,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
