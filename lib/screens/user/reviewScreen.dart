import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qatar_app/util/size.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  //Feedback variables
  final TextEditingController descriptionController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int feedBackRating = 5;
  bool isLoading = false;
  List<bool> isSelected = [false, false, false, false, true];
  int selectedIndex = 4;
  _onTap(int index) {
    setState(() {
      for (var i = 0; i < 5; i++) isSelected[i] = false;
      isSelected[index] = true;
    });
  }

  Widget rating(int x, IconData iconData, String description) {
    return Column(
      children: [
        IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              iconData,
              size: isSelected[x] ? 50 : 40,
            ),
            color: isSelected[x] ? Color(0xff1e4dff) : Colors.grey,
            onPressed: () {
              _onTap(x);
              setState(() {
                feedBackRating = x + 1;
              });
            }),
        isSelected[x]
            ? Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xff1e4dff),
                ),
              )
            : SizedBox(
                height: 18,
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text(
          "FeedBack",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 2.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
                spreadRadius: -15,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              FontAwesome.chevron_circle_left,
              size: 30,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: getY(context) * 0.8,
              width: getX(context) * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Text(
                    "How was your experience?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      rating(0, MdiIcons.emoticonFrownOutline, "Terrible"),
                      rating(1, MdiIcons.emoticonSadOutline, "Bad"),
                      rating(2, MdiIcons.emoticonNeutralOutline, "Satisfied"),
                      rating(3, MdiIcons.emoticonHappyOutline, "Good"),
                      rating(4, MdiIcons.emoticonExcitedOutline, "Great"),
                    ],
                  ),
                  new Text(
                    "Describe what you have experienced",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        borderSide: new BorderSide(width: 2),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
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
                                    "Send",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: null,
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
