import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';

class AddRequest extends StatefulWidget {
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String dropDownValue = "Old Airport";
  final locationList = ["Old Airport", "Bin Mahmoud", "Plaza Mall"];
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final buildingController = TextEditingController();
  final descriptionController = TextEditingController();

  final dbRef = FirebaseDatabase.instance.reference().child("requests");

  _validate() {
    if (_formKey.currentState.validate()) {
      dbRef.push().set({
        "name": nameController.text,
        "email": emailController.text,
        "building": buildingController.text,
        "phone": phoneController.text,
        "location": dropDownValue,
        "description": descriptionController.text,
        "modified": new DateTime.now().toUtc().toString(),
        "status": "In Progress",
      }).then((_) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Successfully Added')));

        emailController.clear();
        nameController.clear();
        phoneController.clear();
        buildingController.clear();
        descriptionController.clear();
      }).catchError((onError) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(onError)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Request Form"),
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
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
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
                  decoration: InputDecoration(
                    hintText: "Phone",
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
                  decoration: InputDecoration(
                    hintText: "Email",
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
                    hintText: "Building",
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
                  maxLines: 6,
                  decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Submit"),
                      onPressed: _validate,
                    ),
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
