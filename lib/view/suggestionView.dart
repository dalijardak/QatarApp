import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qatar_app/models/suggestion.dart';
import 'package:qatar_app/screens/admin/suggestionDetails.dart';
import 'package:qatar_app/services/adminServices.dart';

class SuggestionView extends StatefulWidget {
  final Suggestion suggestion;

  SuggestionView({
    this.suggestion,
  });
  @override
  _SuggestionViewState createState() => _SuggestionViewState();
}

class _SuggestionViewState extends State<SuggestionView> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this request ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                deleteSuggestion(this.widget.suggestion.id);
                Navigator.of(context).pop();
                /*  if (value == "Done") {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Request Sent Seuccessfully",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 18),
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
                    Scaffold.of(context).showSnackBar(
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
                  }*/
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              MaterialCommunityIcons.lightbulb_on,
              color: Colors.yellow,
              size: 30,
            ),
            title: Text(this.widget.suggestion.subject),
            subtitle: Text(this.widget.suggestion.clientFullName),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuggestionDetails(
                  suggestion: this.widget.suggestion,
                ),
              ),
            ),
            onLongPress: _showMyDialog,
          ),
        ],
      ),
    );
  }
}
