class Address {
  final String location;
  final String building;
  final String apartment;

  Address({
    this.location,
    this.building,
    this.apartment,
  });

  factory Address.fromJson(Map<dynamic, dynamic> json) {
    return Address(
      building: json["building"] as String,
      location: json["location"] as String,
      apartment: json["apartment"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "location": location,
        "building": building,
        "apartment": apartment,
      };
}
