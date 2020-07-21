import "package:flutter/material.dart";

class RequestDetails extends StatelessWidget {
  String name;
  String building;
  String location;
  String phone;
  String email;
  String status;
  String date;
  String description;
  RequestDetails(String name, String building, String location, String phone,
      String email, String status, String date, String description) {
    this.name = name;
    this.building = building;
    this.location = location;
    this.phone = phone;
    this.email = email;
    this.status = status;
    this.date = date;
    this.description = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Name"),
            subtitle: Text(this.name),
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
            subtitle: Text(this.date),
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
