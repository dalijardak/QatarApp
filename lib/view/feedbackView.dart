import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qatar_app/elements/rating.dart';
import 'package:qatar_app/models/feedback.dart';
import 'package:qatar_app/screens/admin/feedbackDetails.dart';
import 'package:qatar_app/util/size.dart';

class FeedBackView extends StatelessWidget {
  final FeedBack feedback;
  FeedBackView({this.feedback});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _customIcon(
          this.feedback.rating,
        ),
        title: Text(
          this.feedback.clientName == null ? "error" : this.feedback.clientName,
        ),
        subtitle: Text("Subject : " + this.feedback.requestSubject),
        trailing: SizedBox(
          width: getX(context) * 0.3,
          child: Rating(
            rating: this.feedback.rating - 1,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FeedBackDetails(
                    feedback: this.feedback,
                  )),
        ),
      ),
    );
  }

  // ignore: missing_return
  Icon _customIcon(int rating) {
    switch (rating) {
      case 1:
        return Icon(MdiIcons.emoticonSadOutline, color: Colors.redAccent);
        break;
      case 2:
        return Icon(
          MdiIcons.emoticonConfusedOutline,
          color: Colors.orange,
        );
        break;
      case 3:
        return Icon(
          MdiIcons.emoticonNeutralOutline,
          color: Color(0xffFFD700),
        );
        break;
      case 4:
        return Icon(
          MdiIcons.emoticonHappyOutline,
          color: Colors.greenAccent,
        );
        break;
      case 5:
        return Icon(
          MdiIcons.emoticonExcitedOutline,
          color: Colors.green,
        );
    }
  }
}
