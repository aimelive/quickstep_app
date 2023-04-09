import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String id;
  String imgUrl;
  String username;
  dynamic joinedAt;
  /*
      joinedAt: should be DateTime, except at invite members page it will 
      be String to accept the email
  */

  User({
    required this.id,
    required this.imgUrl,
    required this.username,
    required this.joinedAt,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json["id"],
      username: json["username"],
      imgUrl: json["img"],
      joinedAt: DateTime.parse(json["joinedAt"]),
    );
  }
}

class MoveUser {
  User user;
  LatLng location;

  MoveUser({
    required this.user,
    required this.location,
  });
}

class ChatMessage {
  User user;
  String message;
  DateTime sentAt;
  bool seen;

  ChatMessage({
    required this.user,
    required this.message,
    required this.sentAt,
    this.seen = false,
  });
}
