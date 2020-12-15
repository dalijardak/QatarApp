class FeedBack {
  final String clientId;
  final String clientName;
  final String requestId;
  final String requestSubject;
  final int rating;
  final String description;
  FeedBack({
    this.clientId,
    this.clientName,
    this.requestId,
    this.requestSubject,
    this.rating,
    this.description,
  });

  factory FeedBack.fromJson(Map<dynamic, dynamic> json) {
    return FeedBack(
      clientId: json["clientId"],
      clientName: json["clientName"],
      requestId: json["requestId"],
      requestSubject: json["requestSubject"],
      rating: json["rating"],
      description: json["description"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "clientId": clientId,
        "clientName": clientName,
        "requestId": requestId,
        "requestSubject": requestSubject,
        "rating": rating,
        "description": description,
      };
}
