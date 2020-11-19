import 'package:qatar_app/models/requestList.dart';

import 'address.dart';

class Client {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final Address address;
  final RequestList requestList;

  Client({
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.address,
    this.requestList,
  });
  factory Client.fromJson(Map<dynamic, dynamic> json) {
    return Client(
      fullName: json["fullName"] as String,
      email: json["email"] as String,
      phoneNumber: json["phoneNumber"] as String,
      address: Address.fromJson(json["address"]),
      //requestList: RequestList.fromJson(json.),
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        "phoneNumber": phoneNumber,
        "address": address.toJson(),
        //"requests": requestList.toJson(),
      };
}
