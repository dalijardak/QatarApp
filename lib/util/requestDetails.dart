/*import "package:flutter/material.dart";

class UserRequestDetails extends StatelessWidget {
  final String subject;
  final String building;
  final String location;
  final String phone;
  final String email;
  final String status;
  final String date;
  final String description;
  UserRequestDetails({
    this.subject,
    this.building,
    this.location,
    this.phone,
    this.email,
    this.status,
    this.date,
    this.description,
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
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Name"),
            subtitle: Text(this.subject),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Building"),
            subtitle: Text(this.building),
          ),
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text("Location"),
            subtitle: Text(this.location),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Phone Number"),
            subtitle: Text(this.phone),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            subtitle: Text(this.email),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Status"),
            subtitle: Text(this.status),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Date Sent"),
            subtitle: Text(this.date.substring(0, 16)),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text("Description"),
            subtitle: Text(this.description),
          ),
        ],
      ),
    );
  }
}
*/
