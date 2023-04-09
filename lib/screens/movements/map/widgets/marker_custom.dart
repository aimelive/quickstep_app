import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickstep_app/models/user.dart';
import 'package:quickstep_app/utils/colors.dart';

import 'package:screenshot/screenshot.dart';

Future<Marker> customMarker(
  MoveUser moveUser,
) async {
  final cont = ScreenshotController();
  final bytes = await cont.captureFromWidget(Material(
    color: Colors.transparent,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: lightPrimary,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipOval(
            child: Image.network(
              moveUser.user.imgUrl,
              fit: BoxFit.cover,
              width: 35,
              height: 35,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: lightPrimary,
            borderRadius: BorderRadius.circular(25),
          ),
          width: 15,
          height: 15,
        ),
      ],
    ),
  ));

  return Marker(
    markerId: MarkerId(moveUser.user.id),
    position: moveUser.location,
    infoWindow: InfoWindow(
      title: moveUser.user.username,
      snippet: moveUser.user.joinedAt.runtimeType == String
          ? moveUser.user.joinedAt
          : null,
    ),
    icon: BitmapDescriptor.fromBytes(bytes),
  );
}
