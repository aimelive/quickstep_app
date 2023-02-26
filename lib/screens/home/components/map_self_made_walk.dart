import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:quickstep_app/models/self_made_walk.dart';

import '../../../utils/colors.dart';
import '../../movements/map/movement_live_map.dart';
import '../../movements/map/widgets/warn_dialog.dart';
import '../../movements/widgets/app_bar_2.dart';

enum SelfMadeWalkMapMode { idle, walk }

class SelfMadeWalkMap extends StatefulWidget {
  const SelfMadeWalkMap({
    super.key,
    required this.points,
    required this.mode,
    required this.startedAt,
  });
  final Map<String, LatLng> points;
  final SelfMadeWalkMapMode mode;
  final DateTime startedAt;

  @override
  State<SelfMadeWalkMap> createState() => _SelfMadeWalkMapState();
}

class _SelfMadeWalkMapState extends State<SelfMadeWalkMap> {
  late LatLng origin;
  late LatLng destination;

  LatLng? currentLocation;

  double zoomLevel = 17;

  Map<String, Marker> markers = {};

  GoogleMapController? googleMapController;

  List<LatLng> polylineDestinationCoordinates = [];
  List<LatLng> polylineCurrentLocationCoordinates = [];

  @override
  void initState() {
    origin = widget.points["origin"]!;
    destination = widget.points["destination"]!;

    getRoutePolylines();

    if (widget.mode == SelfMadeWalkMapMode.walk) {
      getLocation();
    }
    super.initState();
  }

  void getRoutePolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
        origin.latitude,
        origin.longitude,
      ),
      PointLatLng(
        destination.latitude,
        destination.longitude,
      ),
    );
    if (result.points.isNotEmpty) {
      for (PointLatLng point in result.points) {
        polylineDestinationCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  void updateCurrentRoutePolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(
          origin.latitude,
          origin.longitude,
        ),
        PointLatLng(
          currentLocation!.latitude,
          currentLocation!.longitude,
        ),
      );
      if (result.points.isNotEmpty) {
        for (PointLatLng point in result.points) {
          polylineCurrentLocationCoordinates.add(
            LatLng(point.latitude, point.longitude),
          );
        }
        if (!mounted) return;
        setState(() {});
      }
    } catch (e) {
      print("We can't show current route offline");
    }
  }

  void getLocation() async {
    Location location = Location();
    final _resData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(
        _resData.latitude!,
        _resData.longitude!,
      );
    });

    location.onLocationChanged.listen((newLoc) {
      if (!mounted) return;
      setState(() {
        currentLocation = LatLng(
          newLoc.latitude!,
          newLoc.longitude!,
        );
      });

      if (googleMapController != null) {
        googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: zoomLevel,
              target: LatLng(
                currentLocation!.latitude,
                currentLocation!.longitude,
              ),
            ),
          ),
        );
        addMarker(
          "currentLocation",
          currentLocation!,
          "Dear Aime, Current Location",
          "This is your current location",
        );
        updateCurrentRoutePolyline();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final leave = await showDialog<bool>(
          context: context,
          barrierColor: Colors.black26,
          builder: ((context) {
            return const WarnDialogWidget();
          }),
        );
        if (leave == true) {
          return true;
        }
        return false;
      },
      child: Container(
        color: primary,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: primary,
              elevation: 0.0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              flexibleSpace: const Hero(
                tag: "appbar-hero-custom-1",
                child: Material(
                  color: Colors.transparent,
                  child: AnotherCustomAppBar(
                    title: "Self-made Walk",
                  ),
                ),
              ),
              toolbarHeight: 100,
            ),
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: origin,
                      zoom: zoomLevel,
                    ),
                    mapType: MapType.hybrid,
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("destination-route"),
                        points: polylineDestinationCoordinates,
                        color: lightPrimary,
                      ),
                      Polyline(
                        polylineId: const PolylineId("current-route"),
                        points: polylineCurrentLocationCoordinates,
                        color: Colors.green.shade400,
                        width: 6,
                      ),
                    },
                    myLocationButtonEnabled: false,
                    onMapCreated: (controller) {
                      googleMapController = controller;
                      addMarker(
                        "origin",
                        origin,
                        "Aime Ndayambaje - Origin",
                        "The origin location",
                      );
                      addMarker(
                        "destination",
                        destination,
                        "Aime Ndayambaje - Destination",
                        "The destination location",
                      );
                    },
                    markers: markers.values.toSet(),
                  ),
                ),
                if (widget.mode == SelfMadeWalkMapMode.walk)
                  Positioned(
                    bottom: 20.h,
                    right: 20.w,
                    left: 20.w,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentLocation == null) return;
                        final walk = SelfMadeWalk(
                          id: 4,
                          initialPosition: origin,
                          finalPosition: currentLocation!,
                          destinationPosition: destination,
                          title: "Aime Ndayambaje - Nice walk",
                          createdAt: widget.startedAt,
                          endedAt: DateTime.now(),
                        );
                        print(walk);
                      },
                      child: const Text("Stop"),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addMarker(String id, LatLng location, String title, String desc) async {
    final marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: desc,
      ),
    );

    setState(() {
      markers[id] = marker;
    });
  }
}
