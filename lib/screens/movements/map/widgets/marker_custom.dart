import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickstep_app/models/user.dart';

Marker customMarker(
  User user,
) {
  return Marker(
    markerId: MarkerId(user.id),
    position: user.location,
    infoWindow: InfoWindow(
      title: user.username,
      // snippet: user.caption,
    ),

      
  );
}
