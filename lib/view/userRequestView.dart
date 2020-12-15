import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qatar_app/models/feedback.dart';
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/screens/user/userRequestDetails.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qatar_app/services/authentification.dart';
import 'package:qatar_app/services/userServices.dart';

class UserRequestView extends StatefulWidget {
  final String requestId;
  final Request request;
  UserRequestView({
    this.requestId,
    this.request,
  });
  @override
  _UserRequestViewState createState() => _UserRequestViewState();
}

class _UserRequestViewState extends State<UserRequestView> {
  Duration fiveSec = Duration(seconds: 5);
  Timer timer;
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(Auth().auth.currentUser.uid)
        .child("requests")
        .onChildChanged
        .first;
    WidgetsBinding.instance.addPostFrameCallback((_) => _isFinished());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _dateDiff() {
    var dateNow = new DateTime.now();
    var dateThen = DateTime.parse(this.widget.request.date);
    var duration = dateNow.difference(dateThen);
    if (duration.inSeconds < 60)
      return duration.inSeconds.toString() + " seconds ";
    else if (duration.inMinutes < 60)
      return duration.inMinutes.toString() + " minutes";
    else if (duration.inHours < 24)
      return duration.inHours.toString() + " hours";
    else if (duration.inDays < 30)
      return duration.inDays.toString() + " days";
    else
      return ((duration.inDays ~/ 30).toString() + " month");
  }

  // ignore: missing_return
  Icon _setIcon() {
    switch (this.widget.request.status) {
      case "Finished":
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 30,
        );
        break;
      case "Pending":
        return Icon(
          MaterialCommunityIcons.dots_horizontal_circle,
          color: Colors.orange,
          size: 30,
        );
        break;
      case "In Progress":
        return Icon(
          MaterialCommunityIcons.progress_clock,
          color: Color(0xffFFD700),
          size: 30,
        );
        break;
    }
  }

  int feedBackRating = 5;
  TextEditingController description = new TextEditingController(text: "");
  bool done = false;
  List<bool> isSelected = [false, false, false, false, false];
  _onTap(int index) {
    setState(() {
      feedBackRating = index + 1;
      for (var i = 0; i <= index; i++) isSelected[i] = true;
      for (var i = index + 1; i < 5; i++) isSelected[i] = false;
    });
  }

  void _isFinished() {
    if (this.widget.request.status == "Finished" &&
        this.widget.request.feedbackRating == 0) {
      showDialog(
        barrierDismissible: true,
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return done
                ? AlertDialog(
                    content: Text("Thank you for your support"),
                  )
                : WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      title: Text(
                        'Your maintainence request \"${this.widget.request.subject}\" is finished !',
                        textAlign: TextAlign.center,
                      ),
                      content: Container(
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Rate our service',
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: IconButton(
                                      icon: isSelected[0]
                                          ? Icon(
                                              Icons.star,
                                              color: Color(0xffFFD700),
                                            )
                                          : Icon(
                                              Icons.star_border,
                                              color: Colors.grey,
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          _onTap(0);
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: isSelected[1]
                                        ? Icon(
                                            Icons.star,
                                            color: Color(0xffFFD700),
                                          )
                                        : Icon(
                                            Icons.star_border,
                                            color: Colors.grey,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _onTap(1);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: isSelected[2]
                                        ? Icon(
                                            Icons.star,
                                            color: Color(0xffFFD700),
                                          )
                                        : Icon(
                                            Icons.star_border,
                                            color: Colors.grey,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _onTap(2);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: isSelected[3]
                                        ? Icon(
                                            Icons.star,
                                            color: Color(0xffFFD700),
                                          )
                                        : Icon(
                                            Icons.star_border,
                                            color: Colors.grey,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _onTap(3);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: isSelected[4]
                                        ? Icon(
                                            Icons.star,
                                            color: Color(0xffFFD700),
                                          )
                                        : Icon(
                                            Icons.star_border,
                                            color: Colors.grey,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        _onTap(4);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "If you have encounterd any issue please let us know"),
                                  ),
                                  TextField(
                                    controller: description,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(15.0),
                                        borderSide: new BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(15.0),
                                        borderSide: new BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  /*FlatButton(
                                    child: Text(
                                      'Cancel',
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),*/
                                  FlatButton(
                                    child: Text(
                                      'Submit',
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                    onPressed: () {
                                      sendFeedback(
                                        feedBack: new FeedBack(
                                          requestId: this.widget.requestId,
                                          clientName: Auth()
                                              .auth
                                              .currentUser
                                              .displayName,
                                          rating: feedBackRating,
                                          description: description.text,
                                          clientId: Auth().auth.currentUser.uid,
                                          requestSubject:
                                              this.widget.request.subject,
                                        ),
                                      ).whenComplete(() {
                                        setState(() {
                                          done = true;
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: _setIcon(),
            title: Text(this.widget.request.subject),
            trailing: Text(_dateDiff() + " ago"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UserRequestDetails(request: this.widget.request),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
