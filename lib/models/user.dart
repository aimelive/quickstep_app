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
}

List<User> dummyUsers = [
  User(
    id: "user-unique-id-0",
    imgUrl: "aime.png",
    username: "Aimelive",
    caption:
        "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
    location: const LatLng(
      1.122,
      33.578,
    ),
  ),
  User(
    id: "user-unique-id-1",
    imgUrl: "aime.png",
    username: "Diamond",
    caption:
        "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
    location: const LatLng(
      1.122,
      33.578,
    ),
  ),
  User(
    id: "user-unique-id-2",
    imgUrl: "map.jpeg",
    username: "Feza",
    caption:
        "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
    location: const LatLng(
      1.122,
      33.578,
    ),
  ),
  User(
    id: "user-unique-id-3",
    imgUrl: "aime.png",
    username: "Hirwa Lucky",
    caption:
        "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
    location: const LatLng(
      1.122,
      33.578,
    ),
  ),
  User(
    id: "user-unique-id-4",
    imgUrl: "zebra.png",
    username: "Ndayambaje",
    caption:
        "Joined this movement at 12:40 PM, 2 min ago, he is now at 3rd Kicukiro bus stop",
    location: const LatLng(
      1.122,
      33.578,
    ),
  ),
];
