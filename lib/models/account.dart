class Account {
  String userId, fullName, email, username, profilePic;
  DateTime createdAt;

  Account({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.username,
    required this.profilePic,
    required this.createdAt,
  });

  static Map<String, dynamic> toMap(Account account) {
    return {
      "userId": account.userId,
      "fullName": account.fullName,
      "email": account.email,
      "username": account.username,
      "profilePic": account.profilePic,
      "createdAt": account.createdAt,
    };
  }

  static Account fromMap(dynamic json) {
    return Account(
      userId: json["userId"],
      fullName: json["fullName"],
      email: json["email"],
      username: json["username"],
      profilePic: json["profilePic"],
      createdAt: json["createdAt"],
    );
  }

  // static Account fromJson(dynamic json) {
  //   return Account(
  //     userId: json["data"]["user"]["_id"],
  //     fullName: json["data"]["user"]["fullName"],
  //     email: json["data"]["user"]["email"],
  //     username: json["data"]["user"]["fullName"],
  //     profilePic:
  //         "https://cdn.pixabay.com/photo/2023/02/08/07/32/vietnamese-woman-7775904_1280.jpg",
  //     createdAt: DateTime.parse(json["data"]["user"]["createdAt"]),
  //   );
  // }
}
