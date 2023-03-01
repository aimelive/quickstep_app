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
}
