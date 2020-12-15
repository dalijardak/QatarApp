import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/services/adminServices.dart';
import 'package:validators/validators.dart';

class AddRequestAdmin extends StatefulWidget {
  @override
  _AddRequestAdminState createState() => _AddRequestAdminState();
}

class _AddRequestAdminState extends State<AddRequestAdmin> {
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
  final subjectController = TextEditingController();
  bool isLoading = false;

  DateTime now = DateTime.now();
  _validate() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      sendRequestAdmin(
        new Request(
          subject: subjectController.text,
          clientName: clientNameController.text,
          email: emailController.text,
          phone: phoneController.text,
          location: dropDownValue,
          building: buildingController.text,
          apartment: appartementController.text,
          description: descriptionController.text,
          status: "Pending",
          date: now.toString(),
          imgUrl: "none",
          imgPath: "N/A",
          feedbackRating: 0,
          feedbackDescription: "",
        ),
      ).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value == "Done") {
          appartementController.clear();
          emailController.clear();
          clientNameController.clear();
          phoneController.clear();
          buildingController.clear();
          descriptionController.clear();
          subjectController.clear();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Request Sent Seuccessfully",
                    style: TextStyle(color: Colors.green, fontSize: 18),
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
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } else if (value == "Timeout" || value == "Error") {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "An Error Has Occurred",
                    style: TextStyle(color: Colors.red, fontSize: 18),
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
        }
      });
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
                leading: const Icon(Icons.person, color: Colors.redAccent),
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
                leading: const Icon(Icons.phone, color: Colors.redAccent),
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
                leading: const Icon(Icons.email, color: Colors.redAccent),
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
                leading: const Icon(Icons.home, color: Colors.redAccent),
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
                leading: const Icon(Icons.home, color: Colors.redAccent),
                title: TextFormField(
                  controller: appartementController,
                  decoration: InputDecoration(
                    labelText: "Apartement",
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
                leading: Icon(Icons.location_city, color: Colors.redAccent),
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
                leading: const Icon(Icons.subject, color: Colors.redAccent),
                title: TextFormField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    labelText: "Subject",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a subject';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.description, color: Colors.redAccent),
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
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: isLoading
                    ? CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      )
                    : RaisedButton(
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Text(
                          "Submit",
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
