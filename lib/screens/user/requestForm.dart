import 'package:flutter/material.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/services/userServices.dart';
import 'package:qatar_app/util/size.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'dart:io';

class AddRequest extends StatefulWidget {
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController =
      new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  bool isLoading = false;
  File _image;
  String imgUrl = "no image";

  //to pick and Image
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker
        .getImage(source: ImageSource.gallery)
        .catchError((test) => print(test));

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Image with Camera
  Future takeImage() async {
    final pickedFile = await picker
        .getImage(source: ImageSource.camera)
        .catchError((test) => print("WOOOOOOOOOOOOOW"));

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //to upload the image
  Future uploadFile() async {
    if (_image == null)
      setState(() {
        imgUrl = "none";
      });
    else {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('requests/${Path.basename(_image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete.catchError((test) => print(test));
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          imgUrl = fileURL;
        });
      });
    }
  }

  DateTime now = DateTime.now();

  //Validation
  _validate() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      clientInfos().then((value) {
        setState(() {
          isLoading = false;
        });
        if (value == null)
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
        else {
          uploadFile().then(
            (_) => sendRequest(
              new Request(
                subject: subjectController.text,
                clientName: value.fullName,
                email: value.email,
                phone: value.phoneNumber,
                location: value.address.location,
                building: value.address.building,
                apartment: value.address.apartment,
                description: descriptionController.text,
                status: "Pending",
                date: now.toString(),
                imgUrl: imgUrl,
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
            }),
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
          backgroundColor: Color.fromRGBO(153, 5, 5, 1),
          title: Text("Add Request"),
          centerTitle: true,
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
                      height: getY(context) * 0.15,
                      width: getX(context) * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/maintenance.png"),
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
                      padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Attachment",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: _image != null
                              ? Container(
                                  height: getY(context) * 0.3,
                                  width: getX(context) * 0.6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.file(_image).image,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: getY(context) * 0.2,
                                  width: getX(context) * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: Colors.black),
                                    color: Color.fromRGBO(217, 216, 212, 1),
                                  ),
                                  child: Center(
                                    child: Text("Upload a file"),
                                  ),
                                ),
                        ),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: _image == null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RaisedButton(
                                      child: Icon(Icons.folder),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        side: BorderSide(color: Colors.red),
                                      ),
                                      onPressed: getImage,
                                      color: Colors.white,
                                    ),
                                    RaisedButton(
                                      child: Icon(Icons.camera_alt),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        side: BorderSide(color: Colors.red),
                                      ),
                                      onPressed: takeImage,
                                      color: Colors.white,
                                    )
                                  ],
                                )
                              : RaisedButton(
                                  child: Text('Clear Image'),
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                ),
                        ),
                      ],
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
