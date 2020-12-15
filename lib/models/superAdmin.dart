class SuperAdmin {
  final String id;
  final String name;

  SuperAdmin({
    this.id,
    this.name,
  });

  factory SuperAdmin.fromJson(Map<dynamic, dynamic> json) {
    return SuperAdmin(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
