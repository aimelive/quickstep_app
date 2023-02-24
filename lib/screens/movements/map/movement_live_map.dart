import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:image/image.dart' as image;

import 'over_map_widget.dart';
import 'widgets/circular_fab_widget.dart';

const LatLng currentLocation = LatLng(-1.9504946, 30.0549678);

class MovementLiveMap extends StatefulWidget {
  const MovementLiveMap({super.key});

  @override
  State<MovementLiveMap> createState() => _MovementLiveMapState();
}

class _MovementLiveMapState extends State<MovementLiveMap> {
  late GoogleMapController mapController;
  // final key = GlobalKey();
  Map<String, Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: currentLocation,
                  zoom: 18,
                ),
                mapType: MapType.hybrid,
                onMapCreated: (controller) {
                  mapController = controller;
                  addMarker("uniqueid", currentLocation);
                },
                myLocationButtonEnabled: false,
                markers: markers.values.toSet(),
              ),
              const OverMapWidget(),
              // Positioned(
              //   bottom: 0,
              //   left: 100,
              //   child: RepaintBoundary(
              //     key: key,
              //     child: const CircleAvatar(
              //       backgroundColor: primary,
              //       radius: 100,
              //       child: CircleAvatar(
              //         radius: 90,
              //         backgroundImage: NetworkImage(
              //           'https://cdn.pixabay.com/photo/2016/11/23/17/25/woman-1853939_1280.jpg',
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: const CircularFabWidget(),
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    // var markerIcon = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(size: Size(64, 64)),
    //   "assets/images/aime.png",
    // );
    // var url =
    //     "https://cdn.pixabay.com/photo/2016/11/23/17/25/woman-1853939_1280.jpg";
    // var bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
    //     .buffer
    //     .asUint8List();
    // image.Image? img = image.decodeImage(bytes);
    // image.Image resized = image.copyResize(img!, width: 150, height: 150);
    // Uint8List resizedImg = Uint8List.fromList(image.encodePng(resized));

    // final boundary =
    //     key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    // final image = await boundary?.toImage();
    // final byteData = await image?.toByteData(format: ImageByteFormat.png);
    // final imageBytes = byteData?.buffer.asUint8List();
    // print(imageBytes);
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: "Aime Ndayambaje - Gisenyi",
        snippet:
            "Some description of the current location by aimelive and ndayambaje",
      ),
      // icon: BitmapDescriptor.fromBytes(resizedImg),
      // icon: markerIcon,
    );
    markers[id] = marker;
    setState(() {});
  }
}
