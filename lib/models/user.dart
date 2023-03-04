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

List<User> dummyUsers = [
  // User(
  //   id: "user-unique-id-0",
  //   imgUrl: "aime.png",
  //   username: "Aimelive",
  //   caption:
  //       "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
  //   location: const LatLng(-1.9172235075192345, 30.081694631126986),
  // ),
  // User(
  //   id: "user-unique-id-1",
  //   imgUrl: "aime.png",
  //   username: "Diamond",
  //   caption:
  //       "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
  //   location: const LatLng(-1.9167999680077046, 30.082668172142643),
  // ),
  // User(
  //   id: "user-unique-id-2",
  //   imgUrl: "map.jpeg",
  //   username: "Feza",
  //   caption:
  //       "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
  //   location: const LatLng(-1.9163382716640436, 30.081935153024972),
  // ),
  // User(
  //   id: "user-unique-id-3",
  //   imgUrl: "aime.png",
  //   username: "Hirwa Lucky",
  //   caption:
  //       "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
  //   location: const LatLng(-1.9167618112898062, 30.08132430376024),
  // ),
];
