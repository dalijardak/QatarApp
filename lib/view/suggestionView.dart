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
          ),
        ],
      ),
    );
  }
}
