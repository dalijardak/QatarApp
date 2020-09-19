class User {
  final name;
  final surName;
  final email;
  final phoneNumber;
  final password;

  User({
    this.name,
    this.surName,
    this.email,
    this.phoneNumber,
    this.password,
  });
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      name: json["username"] as String,
      surName: json["name"] as String,
      email: json["email"] as String,
      phoneNumber: json["phone"] as String,
      password: json["password"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        "surName": surName,
        'email': email,
        "phoneNumber": phoneNumber,
        "password": password,
      };
}
