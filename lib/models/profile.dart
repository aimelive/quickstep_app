class Profile {
  String userId, username, imgUrl, email;

  Profile({
    required this.userId,
    required this.username,
    required this.imgUrl,
    required this.email,
  });

  static Profile fromJson(dynamic json) {
    return Profile(
      userId: json["userId"],
      username: json["username"],
      imgUrl: json["imgUrl"],
      email: json["email"],
    );
  }
}
