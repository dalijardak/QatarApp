import 'package:qatar_app/services/authentification.dart';

class Request {
  final String id;
  final String subject;
  final String clientName;
  final String building;
  final String location;
  final String apartment;
  final String phone;
  final String email;
  final String status;
  final String date;
  final String description;
  final String imgUrl;
  final String imgPath;
  final String clientId;
  final int feedbackRating;
  final String feedbackDescription;
  Request({
    this.id,
    this.subject,
    this.clientName,
    this.building,
    this.location,
    this.apartment,
    this.phone,
    this.email,
    this.status,
    this.date,
    this.description,
    this.imgUrl,
    this.imgPath,
    this.clientId,
    this.feedbackRating,
    this.feedbackDescription,
  });

  factory Request.fromJson(Map<dynamic, dynamic> json) {
    return Request(
      id: json["id"] as String,
      clientName: json["clientName"] as String,
      subject: json["subject"] as String,
      email: json["email"] as String,
      building: json["building"] as String,
      apartment: json["apartment"] as String,
      location: json["location"] as String,
      phone: json["phone"] as String,
      status: json["status"] as String,
      date: json["date"] as String,
      description: json["description"] as String,
      imgUrl: json["imgUrl"] as String,
      imgPath: json["imgPath"] as String,
      clientId: json["clientId"] as String,
      feedbackRating: json["feedbackRating"] as int,
      feedbackDescription: json["feedbackDescription"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "clientName": clientName,
        "subject": subject,
        "email": email,
        "building": building,
        "apartment": apartment,
        "location": location,
        "phone": phone,
        "date": date,
        "description": description,
        "status": status,
        "clientId": Auth().auth.currentUser.uid,
        "imgUrl": imgUrl,
        "imgPath": imgPath,
        "feedbackRating": feedbackRating,
        "feedbackDescription": feedbackDescription,
      };

  Map<String, dynamic> myRequesttoJson() => {
        "date": date,
        "subject": subject,
        "description": description,
        "status": status,
        "imgUrl": imgUrl,
        "feedbackRating": feedbackRating,
      };
}
