import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:quickstep_app/controllers/self_made_walks_controller.dart';
import 'package:quickstep_app/models/self_made_walk.dart';
import 'package:quickstep_app/models/user.dart';
import 'package:quickstep_app/screens/movements/map/widgets/marker_custom.dart';
import 'package:quickstep_app/services/auth_service.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/keys.dart';
import '../../../movements/map/widgets/warn_dialog.dart';
import '../../../movements/widgets/app_bar_2.dart';
import 'save_walk_dialog.dart';

enum SelfMadeWalkMapMode { idle, walk }

class SelfMadeWalkMap extends StatefulWidget {
  const SelfMadeWalkMap(
      {super.key,
      required this.points,
      required this.mode,
      required this.startedAt,
      this.walk});
  final Map<String, LatLng> points;
  final SelfMadeWalkMapMode mode;
  final DateTime startedAt;
  final SelfMadeWalk? walk;

  @override
  State<SelfMadeWalkMap> createState() => _SelfMadeWalkMapState();
}

class _SelfMadeWalkMapState extends State<SelfMadeWalkMap> {
  final walkController = Get.put(WalksController());
  final profile = AuthService().getAuth();

  late LatLng origin;
  late LatLng destination;
  late LatLng finalLoc;

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
      polylineCurrentLocationCoordinates = [origin];
      getLocation();
    } else {
      polylineCurrentLocationCoordinates = widget.walk!.coordinates;
    }
    super.initState();
  }

  void getRoutePolylines() async {
    try {
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
        if (!mounted) return;
        setState(() {});
      }
    } catch (e) {
      // print("Unstable internet connection error");
    }
  }

  void getLocation() async {
    Location location = Location();
    final locationData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    });
    if (!mounted) return;
    location.onLocationChanged.listen((newLoc) async {
      if (!mounted) return;
      setState(() {
        currentLocation = LatLng(
          newLoc.latitude!,
          newLoc.longitude!,
        );
      });

      if (googleMapController != null) {
        await addMarker(
          "currentLocation",
          currentLocation!,
          "Dear Aime, Current Location",
          "This is your current location",
        );
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

        if (!mounted) return;
        setState(() {
          polylineCurrentLocationCoordinates.add(currentLocation!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.mode == SelfMadeWalkMapMode.idle) {
          return true;
        }
        final leave = await showDialog<bool>(
          context: context,
          barrierColor: Colors.black26,
          builder: ((context) {
            return const WarnDialogWidget(
              title: "Stop Travelling",
              subtitle:
                  "Changes made on this page will not be saved, are you sure do you want to close?",
              okButtonText: "Close",
            );
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
              flexibleSpace: Hero(
                tag: "appbar-hero-custom-1",
                child: Material(
                  color: Colors.transparent,
                  child: AnotherCustomAppBar(
                    title: widget.walk == null
                        ? "Self-made Walk"
                        : cfl(widget.walk!.title),
                  ),
                ),
              ),
              toolbarHeight: 100.h,
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
                        width: 8,
                        zIndex: 1,
                      ),
                    },
                    myLocationButtonEnabled: false,
                    onCameraMove: (position) {
                      if (widget.mode == SelfMadeWalkMapMode.walk) {
                        if (!mounted) return;
                        setState(() {
                          zoomLevel = position.zoom;
                        });
                      }
                    },
                    onMapCreated: (controller) {
                      googleMapController = controller;
                      addMarker(
                        "origin",
                        origin,
                        "${profile?.fullName} - Origin",
                        "The origin location",
                      );
                      addMarker(
                        "destination",
                        destination,
                        "${profile?.fullName} - Destination",
                        "The destination location",
                      );
                      if (widget.mode == SelfMadeWalkMapMode.idle) {
                        addMarker(
                          "final-made-destination",
                          polylineCurrentLocationCoordinates[
                              polylineCurrentLocationCoordinates.length - 1],
                          "Where I stopped",
                          "This travel took ${getTimer(widget.walk!.createdAt, widget.walk!.endedAt)}",
                        );
                      }
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
                      onPressed: () async {
                        if (currentLocation == null) return;
                        final name = await showGeneralDialog<String>(
                          context: context,
                          barrierLabel: "save-walk",
                          barrierColor: Colors.black26,
                          barrierDismissible: true,
                          transitionDuration: const Duration(milliseconds: 400),
                          transitionBuilder:
                              ((context, animation, secondaryAnimation, child) {
                            final tween = Tween(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            );
                            return SlideTransition(
                              position: tween.animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                              ),
                              child: child,
                            );
                          }),
                          pageBuilder:
                              ((context, animation, secondaryAnimation) {
                            return const SaveWalkDialog();
                          }),
                        );
                        if (name == null) return;
                        await Future.delayed(const Duration(milliseconds: 400));
                        final walk = SelfMadeWalk(
                          id: 1,
                          initialPosition: origin,
                          coordinates: polylineCurrentLocationCoordinates,
                          destinationPosition: destination,
                          title: name,
                          createdAt: widget.startedAt,
                          creatorId:
                              AuthService().getAuth()?.userId ?? "unkown-user",
                          endedAt: DateTime.now(),
                        );
                        await walkController.addWalk(walk);
                        if (!mounted) return;
                        popPage(context);
                      },
                      child: const Text("Stop"),
                    ),
                  )
              ],
            ),
            floatingActionButton: googleMapController == null ||
                    widget.mode != SelfMadeWalkMapMode.idle
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      googleMapController
                          ?.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                          zoom: zoomLevel,
                          target: polylineCurrentLocationCoordinates[
                              polylineCurrentLocationCoordinates.length - 1],
                        ),
                      ));
                    },
                    backgroundColor: primary,
                    child: Icon(
                      Icons.share_location,
                      size: 28.sp,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  addMarker(String id, LatLng location, String title, String desc) async {
    Marker marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: desc,
      ),
    );
    if (id == "final-made-destination" || id == "currentLocation") {
      marker = await customMarker(
        MoveUser(
          user: User(
            id: id,
            imgUrl: profile!.profilePic,
            username: "You",
            joinedAt: desc,
          ),
          location: location,
        ),
      );
    }

    if (!mounted) return;
    setState(() {
      markers[id] = marker;
    });
  }
}
