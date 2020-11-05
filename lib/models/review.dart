class Review {
  final int rating;
  final String description;
  final String clientId;

  Review({
    this.rating,
    this.description,
    this.clientId,
  });

  factory Review.fromJson(Map<dynamic, dynamic> json) {
    return Review(
      rating: json["rating"] as int,
      description: json["description"] as String,
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "rating": rating,
        "description": description,
        "clientId": clientId,
      };
}
