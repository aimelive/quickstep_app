import 'package:flutter/material.dart';
import 'package:quickstep_app/screens/movements/map/menu_pages/messages.dart';

class MapMenu {
  int id;
  String text;
  IconData icon;
  Widget page;

  MapMenu({
    required this.id,
    required this.text,
    required this.icon,
    required this.page,
  });

  static List<MapMenu> items = [
    MapMenu(
      id: 1,
      text: "Messages",
      icon: Icons.message,
      page: const MessagesPage(),
    ),
    MapMenu(
      id: 2,
      text: "Members",
      icon: Icons.group,
      page: const MessagesPage(),
    ),
    MapMenu(
      id: 3,
      text: "Watchers",
      icon: Icons.group_outlined,
      page: const MessagesPage(),
    ),
    MapMenu(
      id: 4,
      text: "Actors",
      icon: Icons.drive_eta,
      page: const MessagesPage(),
    ),
    MapMenu(
      id: 5,
      text: "Settings",
      icon: Icons.settings,
      page: const MessagesPage(),
    ),
  ];
}
