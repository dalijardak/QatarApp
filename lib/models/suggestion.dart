class Suggestion {
  final String id;
  final String subject;
  final String description;
  final String clientId;
  final String clientFullName;

  Suggestion({
    this.id,
    this.subject,
    this.description,
    this.clientId,
    this.clientFullName,
  });

  factory Suggestion.fromJson(Map<dynamic, dynamic> json) {
    return Suggestion(
      subject: json["subject"] as String,
      description: json["description"] as String,
      clientId: json["clientId"] as String,
      clientFullName: json["clientFullName"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "description": description,
        "clientId": clientId,
        "clientFullName": clientFullName,
      };
}
