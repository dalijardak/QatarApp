import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import 'package:qatar_app/models/address.dart';
import 'package:qatar_app/models/client.dart';
import 'package:qatar_app/models/requestList.dart';
import 'package:qatar_app/services/authentification.dart';
import 'package:qatar_app/util/size.dart';
import 'package:validators/validators.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final buildingController = TextEditingController();
  final apartmentController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String dropDownValue = "Old Airport";
  final locationList = ["Old Airport", "Bin Mahmoud", "Madinat Khalifa"];
  bool isLoading = false;

  _validate() {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      Auth()
          .signUp(
        new Client(
          fullName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
          phoneNumber: phoneNumberController.text,
          address: new Address(
            location: dropDownValue,
            building: buildingController.text,
            apartment: apartmentController.text,
          ),
          requestList: new RequestList(requestList: []),
        ),
      )
          .then((value) {
        setState(() => isLoading = false);
        if (value == "Success") {
          fullNameController.clear();
          emailController.clear();
          phoneNumberController.clear();
          buildingController.clear();
          apartmentController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User Created Successfully",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                ],
              ),
              backgroundColor: Colors.black,
            ),
          );
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushNamed(context, "/Admin");
          });
        } else
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.red,
                  )
                ],
              ),
              backgroundColor: Colors.black,
            ),
          );
      });
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
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Create User"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: getY(context),
                width: getX(context) * 0.75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      autofocus: false,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a Valid Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
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
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
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
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      value: dropDownValue,
                      icon: Icon(Icons.arrow_downward),
                      items: locationList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownValue = newValue;
                        });
                      },
                    ),
                    TextFormField(
                      controller: buildingController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: "Building Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.black,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a valid Building Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: apartmentController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: "Apartment ",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a valid Apartment ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
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
                      controller: confirmPasswordController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter a Valid Password";
                        }
                        if (value != passwordController.text) {
                          return "Password Not Match";
                        }
                        return null;
                      },
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.redAccent),
                            )
                          : RaisedButton(
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black),
                              ),
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: _validate,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
