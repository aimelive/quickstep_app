import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelfMadeWalk {
  int id;
  LatLng initialPosition;
  List<LatLng> coordinates;
  LatLng destinationPosition;
  String title;
  DateTime createdAt;
  DateTime endedAt;

  SelfMadeWalk({
    required this.id,
    required this.initialPosition,
    required this.coordinates,
    required this.destinationPosition,
    required this.title,
    required this.createdAt,
    required this.endedAt,
  });

  static SelfMadeWalk fromJSON(dynamic json, int id) {
    // print(json["initialPosition"]["lat"]);
    return SelfMadeWalk(
      id: id,
      initialPosition: LatLng(
        json["initialPosition"]["lat"],
        json["initialPosition"]["long"],
      ),
      coordinates: json["coordinates"]
          .map<LatLng>(
            (position) => LatLng(
              position["lat"]!,
              position["long"]!,
            ),
          )
          .toList(),
      destinationPosition: LatLng(
        json["destinationPosition"]["lat"],
        json["destinationPosition"]["long"],
      ),
      title: json["title"],
      createdAt: json["createdAt"],
      endedAt: json["endedAt"],
    );
  }

  static Map<String, dynamic> toJSON(SelfMadeWalk walk) {
    return {
      "initialPosition": {
        "lat": walk.initialPosition.latitude,
        "long": walk.initialPosition.longitude
      },
      "coordinates": walk.coordinates
          .map((pos) => <String, double>{
                "lat": pos.latitude,
                "long": pos.longitude,
              })
          .toList(),
      "destinationPosition": {
        "lat": walk.destinationPosition.latitude,
        "long": walk.destinationPosition.longitude
      },
      "title": walk.title,
      "createdAt": walk.createdAt,
      "endedAt": walk.endedAt,
    };
  }
}

// List<SelfMadeWalk> walks = [
//   SelfMadeWalk(
//     id: 1,
//     initialPosition: const LatLng(
//       -1.9167688784786698,
//       30.083218087221134,
//     ),
//     finalPosition: const LatLng(
//       -1.9167688784786698,
//       30.081166197413935,
//     ),
//     destinationPosition: const LatLng(
//       -1.9167688784786698,
//       30.081166197413935,
//     ),
//     title: "Another cool night walk",
//     createdAt: DateTime.now(),
//     endedAt: DateTime.now().subtract(const Duration(minutes: 7)),
//   ),
//   SelfMadeWalk(
//     id: 2,
//     initialPosition: const LatLng(
//       -1.9167688784786698,
//       30.083218087221134,
//     ),
//     finalPosition: const LatLng(
//       -1.9167688784786698,
//       30.081166197413935,
//     ),
//     destinationPosition: const LatLng(
//       -1.9167688784786698,
//       30.081166197413935,
//     ),
//     title: "Prince Armstrong kwa Teta kurya ibiraha",
//     createdAt: DateTime.now(),
//     endedAt: DateTime.now().subtract(const Duration(minutes: 20)),
//   ),
//   SelfMadeWalk(
//     id: 3,
//     initialPosition: const LatLng(
//       -1.9167688784786698,
//       30.083218087221134,
//     ),
//     finalPosition: const LatLng(
//       -1.9167688784786698,
//       30.081166197413935,
//     ),
//     destinationPosition: const LatLng(
//       -1.9167688784786698,
//       30.081166197413935,
//     ),
//     title: "Hugue walking to buy some nzuri",
//     createdAt: DateTime.now(),
//     endedAt: DateTime.now().subtract(const Duration(minutes: 7)),
//   ),
// ];
