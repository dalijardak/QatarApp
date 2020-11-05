import "package:flutter/material.dart";
import 'package:qatar_app/models/suggestion.dart';
import 'package:qatar_app/services/authentification.dart';
import 'package:qatar_app/services/userServices.dart';
import 'package:qatar_app/util/size.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  _validate() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      sendSuggestion(
        Suggestion(
          subject: subjectController.text,
          description: descriptionController.text,
          clientId: Auth().auth.currentUser.uid,
          clientFullName: Auth().auth.currentUser.displayName,
        ),
      ).then((value) {
        setState(() {
          isLoading = false;
        });
        subjectController.clear();
        descriptionController.clear();
        if (value == "Done") {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thank you for your support",
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
          title: Text(
            "Suggestions",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Container(
                width: getX(context),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: getY(context) * 0.2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage("assets/suggestions.jpg"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Subject",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: getX(context) * 0.9,
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: subjectController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Subject",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please Enter a Valid Subject";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: getX(context) * 0.9,
                      child: TextFormField(
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
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please Enter a Valid Subject";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: AnimatedSwitcher(
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
                                child: Container(
                                  width: getX(context) * 0.3,
                                  child: Center(
                                    child: Text(
                                      "Send",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: _validate,
                              ),
                      ),
                    )
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
