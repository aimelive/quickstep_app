import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelfMadeWalk {
  int id;
  String creatorId;
  LatLng initialPosition;
  List<LatLng> coordinates;
  LatLng destinationPosition;
  String title;
  DateTime createdAt;
  DateTime endedAt;

  SelfMadeWalk({
    required this.id,
    required this.creatorId,
    required this.initialPosition,
    required this.coordinates,
    required this.destinationPosition,
    required this.title,
    required this.createdAt,
    required this.endedAt,
  });

  static SelfMadeWalk fromJSON(dynamic json, int id) {
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
      creatorId: json["creatorId"],
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
      "creatorId": walk.creatorId,
      "createdAt": walk.createdAt,
      "endedAt": walk.endedAt,
    };
  }
}
