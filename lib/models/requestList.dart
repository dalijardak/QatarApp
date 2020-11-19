import 'package:qatar_app/models/request.dart';

class RequestList {
  final List<Request> requestList;

  RequestList({
    this.requestList,
  });

  factory RequestList.fromJson(Map<String, dynamic> json) {
    return RequestList(
      requestList:
          json["requests"].map((modal) => Request.fromJson(modal)).toList(),
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "requests": requestList,
      };
}
