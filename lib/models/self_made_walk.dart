import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelfMadeWalk {
  int id;
  LatLng initialPosition;
  LatLng finalPosition;
  LatLng destinationPosition;
  String title;
  DateTime createdAt;
  DateTime endedAt;

  SelfMadeWalk({
    required this.id,
    required this.initialPosition,
    required this.finalPosition,
    required this.destinationPosition,
    required this.title,
    required this.createdAt,
    required this.endedAt,
  });
}

List<SelfMadeWalk> walks = [
  SelfMadeWalk(
    id: 1,
    initialPosition: const LatLng(
      -1.9167688784786698,
      30.083218087221134,
    ),
    finalPosition: const LatLng(
      -1.9167688784786698,
      30.081166197413935,
    ),
    destinationPosition: const LatLng(
      -1.9167688784786698,
      30.081166197413935,
    ),
    title: "Another cool night walk",
    createdAt: DateTime.now(),
    endedAt: DateTime.now().subtract(const Duration(minutes: 7)),
  ),
  SelfMadeWalk(
    id: 2,
    initialPosition: const LatLng(
      -1.9167688784786698,
      30.083218087221134,
    ),
    finalPosition: const LatLng(
      -1.9167688784786698,
      30.081166197413935,
    ),
    destinationPosition: const LatLng(
      -1.9167688784786698,
      30.081166197413935,
    ),
    title: "Prince Armstrong kwa Teta kurya ibiraha",
    createdAt: DateTime.now(),
    endedAt: DateTime.now().subtract(const Duration(minutes: 20)),
  ),
  SelfMadeWalk(
    id: 3,
    initialPosition: const LatLng(
      -1.9167688784786698,
      30.083218087221134,
    ),
    finalPosition: const LatLng(
      -1.9167688784786698,
      30.081166197413935,
    ),
    destinationPosition: const LatLng(
      -1.9167688784786698,
      30.081166197413935,
    ),
    title: "Hugue walking to buy some nzuri",
    createdAt: DateTime.now(),
    endedAt: DateTime.now().subtract(const Duration(minutes: 7)),
  ),
];
