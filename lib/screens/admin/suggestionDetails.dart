import "package:flutter/material.dart";
import 'package:qatar_app/models/client.dart';
import 'package:qatar_app/models/suggestion.dart';
import 'package:qatar_app/services/adminServices.dart';

class SuggestionDetails extends StatelessWidget {
  final Suggestion suggestion;
  SuggestionDetails({
    this.suggestion,
  });

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
              subtitle: Text(
                this.suggestion.subject,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Colors.red,
              ),
              title: Text("Description"),
              subtitle: Text(
                this.suggestion.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            FutureBuilder(
              future: clientInfosId(this.suggestion.clientId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var client = snapshot.data;
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, color: Colors.red),
                        title: Text(
                          "Client Name",
                        ),
                        subtitle: Text(
                          client.fullName,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            new PopupMenuItem<String>(
                              child: Container(
                                width: 250,
                                child: ListTile(
                                  leading: Icon(Icons.email, color: Colors.red),
                                  title: Text(
                                    "Email",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    client.email,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            new PopupMenuItem<String>(
                              child: Container(
                                width: 250,
                                child: ListTile(
                                  leading: Icon(Icons.phone, color: Colors.red),
                                  title: Text(
                                    "Phone Number",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    client.phoneNumber,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            new PopupMenuItem<String>(
                              child: Container(
                                width: 250,
                                child: ListTile(
                                  leading: Icon(Icons.location_on,
                                      color: Colors.red),
                                  title: Text(
                                    "Location",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    client.address.location,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            new PopupMenuItem<String>(
                              child: Container(
                                width: 250,
                                child: ListTile(
                                  leading: Icon(Icons.location_city,
                                      color: Colors.red),
                                  title: Text(
                                    "Building",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    client.address.building,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            new PopupMenuItem<String>(
                              child: Container(
                                width: 250,
                                child: ListTile(
                                  leading: Icon(Icons.home, color: Colors.red),
                                  title: Text(
                                    "Apartment",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    client.address.apartment,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else
                  return Container(
                    width: 150,
                    padding: EdgeInsets.all(30),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  );
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}
