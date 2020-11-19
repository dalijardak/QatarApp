import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import 'package:qatar_app/models/address.dart';
import 'package:qatar_app/models/client.dart';
import 'package:qatar_app/models/requestList.dart';
import 'package:qatar_app/services/authentification.dart';
import 'package:qatar_app/util/size.dart';
import 'package:validators/validators.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  _validate(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Auth()
          .signUp(
            new Client(
              fullName: fullNameController.text,
              email: emailController.text,
              password: passwordController.text,
              phoneNumber: phoneNumberController.text,
              address: new Address(
                location: "Old Airport",
                building: "Borj Khalifa",
                apartment: "69",
              ),
              requestList: new RequestList(requestList: []),
            ),
          )
          .then((value) => Navigator.pushNamed(context, "/User"));
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
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: getX(context) * 0.8,
                    height: getY(context) * 0.6,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            controller: fullNameController,
                            autofocus: false,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: "Full Name",
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
                                return 'Please Enter a Building Name';
                              }
                              return null;
                            },
                          ),
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
                            controller: phoneNumberController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
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
                              if (!isNumeric(value)) {
                                return 'Please Enter a valid Phone Number';
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
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: "Confirm Password",
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
                              if (value != passwordController.text) {
                                return "Not Match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
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
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  onTap: () => _validate(
                    context,
                  ), /**FocusScope.of(context).requestFocus(FocusNode()), */
                ),
                bottom: getY(context) * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
