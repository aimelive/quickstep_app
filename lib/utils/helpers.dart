import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Navigating to another page by material page route
void pushPage(BuildContext context, {required Widget to, bool? asDialog}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => to,
        fullscreenDialog: asDialog != null,
      ),
    );

/// Popping the current material page route from the queue
void popPage(BuildContext context) => Navigator.pop(context);

/// Adding horizontal space in a row
SizedBox addHorizontalSpace(double width) {
  return SizedBox(width: width.w);
}

/// Adding vertical space in a row
SizedBox addVerticalSpace(double height) {
  return SizedBox(height: height.h);
}
