import "package:flutter/material.dart";
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/util/size.dart';

class UserRequestDetails extends StatefulWidget {
  final Request request;
  UserRequestDetails({
    this.request,
  });
  @override
  _UserRequestDetailsState createState() => _UserRequestDetailsState();
}

class _UserRequestDetailsState extends State<UserRequestDetails> {
  void showImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          content: Container(
            height: getY(context) * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  this.widget.request.imgUrl,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text("Details"),
        centerTitle: true,
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.red,
              ),
              title: Text("Subject"),
              subtitle: Text(this.widget.request.subject),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.red,
              ),
              title: Text("Status"),
              subtitle: Text(this.widget.request.status),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: Colors.red,
              ),
              title: Text("Date Sent"),
              subtitle: Text(this.widget.request.date.substring(0, 16)),
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Colors.red,
              ),
              title: Text("Description"),
              subtitle: Text(this.widget.request.description),
            ),
            ListTile(
              leading: Icon(
                Icons.image,
                color: Colors.red,
              ),
              title: Text("Provided Image"),
              subtitle: this.widget.request.imgUrl == "none"
                  ? Text("No Image Provided")
                  : Container(
                      height: getY(context) * 0.25,
                      child: Image.network(
                        this.widget.request.imgUrl,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return InkWell(
                              child: child,
                              onTap: showImage,
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Error loading image"),
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ).toList(),
      ),
    );
  }
}
