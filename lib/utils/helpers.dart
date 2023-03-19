import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Navigating to another page by material page route
dynamic pushPage(BuildContext context,
    {required Widget to, bool? asDialog}) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => to,
      fullscreenDialog: asDialog != null,
    ),
  );
}

/// Popping the current material page route from the queue
void popPage(BuildContext context, {dynamic data}) =>
    Navigator.pop(context, data);

/// Adding horizontal space in a row
SizedBox addHorizontalSpace(double width) {
  return SizedBox(width: width.w);
}

/// Adding vertical space in a row
SizedBox addVerticalSpace(double height) {
  return SizedBox(height: height.h);
}

///Get timing duration
String getTimer(DateTime from, DateTime to) {
  final duration = to.difference(from);
  String twoDigits(int n) => n.toString().padLeft(2, '');
  final hours = "${twoDigits(duration.inHours)}hr";
  final minutes = "${twoDigits(duration.inMinutes.remainder(60))}min";
  final seconds = "${twoDigits(duration.inSeconds.remainder(60))}sec";
  return [if (duration.inHours > 0) hours, minutes, seconds].join(' ');
}

//Capitalize first letter of a word
String cfl(String str) {
  if (str.isEmpty) return str;
  if (str.length == 1) return str.toUpperCase();
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}

List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
