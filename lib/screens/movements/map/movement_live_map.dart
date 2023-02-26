import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:quickstep_app/utils/colors.dart';
// import 'package:image/image.dart' as image;

import 'over_map_widget.dart';
import 'widgets/circular_fab_widget.dart';

const googleApiKey = 'AIzaSyC5ubzRytHakIp0hADsvsV5JArqVC4wcfo';



class MovementLiveMap extends StatefulWidget {
  const MovementLiveMap({super.key});

  @override
  State<MovementLiveMap> createState() => _MovementLiveMapState();
}

class _MovementLiveMapState extends State<MovementLiveMap> {
  final LatLng sourceLocation = const LatLng(
    -1.9167688784786698,
    30.083218087221134,
  );
  final LatLng destinationLocation = const LatLng(
    -1.9167688784786698,
    30.081166197413935,
  );

  GoogleMapController? mapController;
  // final key = GlobalKey();
  Map<String, Marker> markers = {};

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _resData = await location.getLocation();
    setState(() {
      currentLocation = _resData;
    });

    location.onLocationChanged.listen((newLoc) {
      if (!mounted) return;
      setState(() {
        currentLocation = newLoc;
      });

      print("Hello World new location,${currentLocation?.latitude}");
      if (mapController != null) {
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 18,
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
            ),
          ),
        );
        addMarker(
          "currentLocation",
          LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
        );
      }
    });
  }

  //get polylinesloc
  void getPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
        sourceLocation.latitude,
        sourceLocation.longitude,
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ),
    );
    if (result.points.isNotEmpty) {
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      // result.points.forEach((PointLatLng point) {
      //   return polylineCoordinates.add(
      //     LatLng(point.latitude, point.longitude),
      //   );
      // });
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(currentLocation);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            if (currentLocation != null)
              GoogleMap(
                initialCameraPosition:  CameraPosition(
                  target: sourceLocation,
                  zoom: 18,
                ),
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: lightPrimary,
                  ),
                },
                compassEnabled: false,
                mapType: MapType.hybrid,
                onMapCreated: (controller) {
                  mapController = controller;
                  addMarker("source", sourceLocation);
                  addMarker("destination", destinationLocation);

                  addMarker(
                    "currentLocation",
                    LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                  );
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

    setState(() {
      markers[id] = marker;
    });
  }
}
