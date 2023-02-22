import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(25.11, 55.37);

class MovementLiveMap extends StatefulWidget {
  const MovementLiveMap({super.key});

  @override
  State<MovementLiveMap> createState() => _MovementLiveMapState();
}

class _MovementLiveMapState extends State<MovementLiveMap> {
  late GoogleMapController mapController;

  Map<String, Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          mapController = controller;
          addMarker("uniqueid", currentLocation);
        },
        markers: markers.values.toSet(),
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(64, 64)),
      "assets/images/aime.png",
    );
    // var url = "https://aimelive.netlify.app/assets/aime-c5b8f203.png";
    // var bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
    //     .buffer
    //     .asUint8List();
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: "Aime Ndayambaje - Gisenyi",
        snippet:
            "Some description of the current location by aimelive and ndayambaje",
      ),
      // icon: BitmapDescriptor.fromBytes(bytes),
      icon: markerIcon,
    );
    markers[id] = marker;
    setState(() {});
  }
}
