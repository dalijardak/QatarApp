import "package:flutter/material.dart";
import 'package:qatar_app/models/request.dart';
import 'package:qatar_app/services/adminServices.dart';
import 'package:qatar_app/util/size.dart';

class RequestDetails extends StatefulWidget {
  final Request request;
  final String requestId;
  RequestDetails({
    this.request,
    this.requestId,
  });
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void showImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          content: Container(
            height: getY(context) * 0.4,
            width: getX(context),
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
    String status = "Pending";
    final statusList = ["Pending", "In Progress", "Finished"];
    Future<void> _showMyDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change Status'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    value: status,
                    icon: Icon(Icons.arrow_downward),
                    items: statusList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        status = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Confirm'),
                onPressed: () => changeRequestStatus(
                  status,
                  this.widget.requestId,
                  this.widget.request.clientId,
                ).then((_) {
                  Navigator.pop(context);
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Successfully Modified",
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
                }).catchError(
                  (test) => _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "An Error Has Occured",
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
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      key: _scaffoldKey,
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
              leading: Icon(Icons.person, color: Colors.red),
              title: Text("Client Name"),
              subtitle: Text(this.widget.request.clientName),
            ),
            ListTile(
              leading: Icon(Icons.subject, color: Colors.red),
              title: Text("Subject"),
              subtitle: Text(this.widget.request.subject),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.red),
              title: Text("Building"),
              subtitle: Text(this.widget.request.building),
            ),
            ListTile(
              leading: Icon(Icons.location_city, color: Colors.red),
              title: Text("Location"),
              subtitle: Text(this.widget.request.location),
            ),
            ListTile(
              leading: Icon(Icons.confirmation_number, color: Colors.red),
              title: Text("Apartment"),
              subtitle: Text(this.widget.request.apartment),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
              title: Text("Phone Number"),
              subtitle: Text(this.widget.request.phone),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text("Email"),
              subtitle: Text(this.widget.request.email),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.red),
              title: Text("Date Sent"),
              subtitle: Text(this.widget.request.date.substring(0, 16)),
            ),
            ListTile(
              leading: Icon(Icons.description, color: Colors.red),
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
            ListTile(
              leading: Icon(Icons.info, color: Colors.red),
              title: Text("Status"),
              subtitle: Text(this.widget.request.status),
              trailing: RaisedButton(
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black),
                ),
                child: Text("Change"),
                onPressed: () => _showMyDialog(context),
              ),
            ),
          ],
        ).toList(),
      ),
    );
  }
}
