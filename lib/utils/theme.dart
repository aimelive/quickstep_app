import 'package:flutter/material.dart';
import 'package:quickstep_app/utils/colors.dart';

// scaffoldBackgroundColor: const Color(0xFFF2F2F3),
class MyThemes {
  static final theme = ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: primary.withOpacity(0.8),
        // shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
          ),
        ),
      ),
    ),
  );
}
