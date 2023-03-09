import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String id;
  String imgUrl;
  String username;
  String caption;
  LatLng location;

  User({
    required this.id,
    required this.imgUrl,
    required this.username,
    required this.caption,
    required this.location,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json["user"],
      username: json["username"],
      imgUrl: "aime.png",
      caption: "No caption",
      location: LatLng(
        json["lat"],
        json["long"],
      ),
    );
  }
}

class RoomMember {
  final String id;
  final String username;

  RoomMember({
    required this.id,
    required this.username,
  });
}
