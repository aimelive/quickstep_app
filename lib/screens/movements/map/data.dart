import 'package:flutter/material.dart';
import 'package:quickstep_app/screens/movements/map/menu_pages/members.dart';
import 'package:quickstep_app/screens/movements/map/menu_pages/messages.dart';
import 'package:quickstep_app/screens/movements/map/menu_pages/settings.dart';

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
      page: MessagesPage(
        onSendMessage: (message) {},
      ),
    ),
    MapMenu(
      id: 2,
      text: "Members",
      icon: Icons.group,
      page: const MembersPage(),
    ),
    MapMenu(
      id: 3,
      text: "Settings",
      icon: Icons.settings,
      page: const SettingsPage(),
    ),
  ];
}
