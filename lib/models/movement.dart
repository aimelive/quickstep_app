enum Role { viewer, creator, member }

class Movement {
  String id;
  String title;
  String description;
  String creator;
  int km;
  int members;
  DateTime createdAt;
  Role role;

  Movement({
    required this.id,
    required this.title,
    required this.description,
    required this.members,
    required this.creator,
    required this.createdAt,
    required this.km,
    required this.role,
  });

  factory Movement.fromJSON(dynamic json) {
    return Movement(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      members: json["actors"].length,
      creator: json["creator"],
      createdAt: DateTime.parse(json["createdAt"]),
      km: 17,
      role: Role.member,
    );
  }
}
