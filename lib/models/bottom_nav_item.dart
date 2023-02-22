import 'package:flutter/material.dart';

class BottomBarItem {
  int index;
  String text;
  IconData icon;
  Color selectedColor;
  BottomBarItem({
    required this.index,
    required this.text,
    required this.icon,
    required this.selectedColor,
  });
}

List<BottomBarItem> menuItems = [
  BottomBarItem(
    index: 0,
    text: "Home",
    icon: Icons.home,
    selectedColor: Colors.amberAccent,
  ),
  BottomBarItem(
      index: 1,
      text: "Activity",
      icon: Icons.local_activity_outlined,
      selectedColor: Colors.blue.shade200),
  BottomBarItem(
      index: 2,
      text: "Live",
      icon: Icons.location_on_outlined,
      selectedColor: Colors.green.shade400),
  BottomBarItem(
    index: 3,
    text: "Profile",
    icon: Icons.account_circle,
    selectedColor: Colors.amberAccent,
  ),
];
//Real-time order tracking (Orders)

// Order
// Travel, 
// Groups (Admin can hide someone's location, information of the current user being displayed
// on a marker)
// Send, send groups