import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/services/userServices.dart';
import 'package:validators/validators.dart';

class AddRequest extends StatefulWidget {
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String dropDownValue = "Old Airport";
  final locationList = ["Old Airport", "Bin Mahmoud", "Madinat Khalifa"];
  final clientNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final buildingController = TextEditingController();
  final appartementController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime now = DateTime.now();
  _validate() {
    if (_formKey.currentState.validate()) {
      sendRequest(
        new Request(
          clientName: clientNameController.text,
          email: emailController.text,
          phone: phoneController.text,
          location: dropDownValue,
          building: buildingController.text,
          apartment: appartementController.text,
          description: descriptionController.text,
          status: "In Progress",
          date: now.toString(),
        ),
      ).then((_) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              "Successfully Sent",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            backgroundColor: Colors.green,
          ),
        );
        appartementController.clear();
        emailController.clear();
        clientNameController.clear();
        phoneController.clear();
        buildingController.clear();
        descriptionController.clear();
      }).catchError(
        (test) => _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              "Error, please try again",
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text("Add Request"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person),
                title: TextFormField(
                  controller: clientNameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (!isNumeric(value)) {
                      return 'Please Enter Your Phone Number';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: TextFormField(
                  controller: buildingController,
                  decoration: InputDecoration(
                    labelText: "Building",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a Building Name';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: TextFormField(
                  controller: appartementController,
                  decoration: InputDecoration(
                    labelText: "Appartement",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a Building Name';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
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
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _validate,
                      child: Text("Submit"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*  ProgressButton.icon(
                    iconedButtons: {
                      ButtonState.idle: IconedButton(
                          text: "Send",
                          icon: Icon(Icons.send, color: Colors.white),
                          color: Colors.deepPurple.shade500),
                      ButtonState.loading: IconedButton(
                          text: "Loading", color: Colors.deepPurple.shade700),
                      ButtonState.fail: IconedButton(
                          text: "Failed",
                          icon: Icon(Icons.cancel, color: Colors.white),
                          color: Colors.red.shade300),
                      ButtonState.success: IconedButton(
                          text: "Success",
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          color: Colors.green.shade400)
                    },
                    onPressed: _validate,
                    state: ButtonState.loading,
                  ),*/
