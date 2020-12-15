class Admin {
  final String id;
  final String fullName;
  final String email;
  final String password;

  Admin({
    this.id,
    this.fullName,
    this.email,
    this.password,
  });

  factory Admin.fromJson(Map<dynamic, dynamic> json) {
    return Admin(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "password": password,
      };
}
