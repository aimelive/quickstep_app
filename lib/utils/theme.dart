import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.r),
            topRight: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
            bottomLeft: Radius.circular(25.r),
          ),
        ),
      ),
    ),
  );
}
