import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:quickstep_app/models/user.dart';
import 'package:quickstep_app/screens/movements/map/widgets/marker_custom.dart';
import 'package:quickstep_app/services/auth_service.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class ChooseLocationDialog extends StatefulWidget {
  const ChooseLocationDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseLocationDialog> createState() => _ChooseLocationDialogState();
}

class _ChooseLocationDialogState extends State<ChooseLocationDialog> {
  LatLng? currentLocation;
  LatLng? choosenLocation;
  final profile = AuthService().getAuth();

  Map<String, Marker> markers = {};

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

    final locationData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });

    location.onLocationChanged.listen((newLoc) {
      if (!mounted) return;
      setState(() {
        currentLocation = LatLng(
          newLoc.latitude!,
          newLoc.longitude!,
        );
      });
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10.0,
      backgroundColor: white,
      insetPadding: EdgeInsets.symmetric(horizontal: 22.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose Location".toUpperCase(),
              style: TextStyle(
                fontSize: 14.5.sp,
                color: primary.withOpacity(0.8),
                fontWeight: FontWeight.w700,
              ),
            ),
            addVerticalSpace(10),
            SizedBox(
              height: 320.h,
              child: Stack(
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    child: currentLocation != null
                        ? GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: currentLocation!,
                              zoom: 16,
                            ),
                            mapType: MapType.hybrid,
                            onMapCreated: (controller) async {
                              addMarker(
                                "current-location",
                                currentLocation!,
                                "My Current Location - Last known",
                                "If this is not your right current location close this dialog and try again",
                              );
                            },
                            onTap: (newLoc) {
                              setState(() {
                                choosenLocation = newLoc;
                              });
                              addMarker(
                                "choosen-location",
                                choosenLocation!,
                                "Choosen Location",
                                "Tap on the map where you want to go",
                              );
                            },
                            markers: markers.values.toSet(),
                          )
                        : null,
                  ),
                  Container(
                    // color: red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                cursorColor: lightPrimary,
                                decoration: InputDecoration(
                                  hintText: "Type search",
                                  fillColor: white,
                                  filled: true,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    // vertical: 5.h,
                                  ),
                                  suffixIcon: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        size: 25.sp,
                                      ),
                                      color: primary,
                                      onPressed: () {},
                                    ),
                                  ),
                                  suffixIconConstraints:
                                      BoxConstraints(maxHeight: 40.h),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.r),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: grey400,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.r),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: lightPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Material(
                            //   borderRadius: BorderRadius.circular(10.r),
                            //   child: InkWell(
                            //     onTap: () {},
                            //     highlightColor: primary.withOpacity(0.2),
                            //     splashColor: white,
                            //     borderRadius: BorderRadius.circular(10.r),
                            //     child: Ink(
                            //       padding: EdgeInsets.symmetric(
                            //         horizontal: 8.w,
                            //         vertical: 6.h,
                            //       ),
                            //       child: Icon(
                            //         Icons.search,
                            //         color: primary,
                            //         size: 25.sp,
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        Container(
                          height: 100.h,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  <int>[].map<Widget>(buildPlaceTile).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (currentLocation != null)
              Container(
                color: lightPrimary,
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 25.sp,
                      color: Colors.grey.shade600,
                    ),
                    addHorizontalSpace(5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current location: ${currentLocation?.latitude},${currentLocation?.longitude}",
                          ),
                          if (choosenLocation != null)
                            Text(
                              "Choosen location: ${choosenLocation?.latitude},${choosenLocation?.longitude}",
                            )
                        ],
                      ),
                    ),
                    // Icon(
                    //   Icons.refresh,
                    //   size: 25.sp,
                    // ),
                  ],
                ),
              ),
            addVerticalSpace(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      popPage(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: const Text("CANCEL"),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (choosenLocation == null) return;
                        Map<String, LatLng> points = {
                          "origin": currentLocation!,
                          "destination": choosenLocation!,
                        };
                        Navigator.pop(
                          context,
                          points,
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("SELECT"),
                    ),
                  )
                ],
              ),
            )
          ],
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
    if (id == "current-location") {
      marker = await customMarker(
        MoveUser(
          user: User(
            id: id,
            imgUrl: profile!.profilePic,
            username: "You",
            joinedAt: null,
          ),
          location: location,
        ),
      );
    }

    setState(() {
      markers[id] = marker;
    });
  }

  Widget buildPlaceTile(int item) {
    return Container(
      color: Colors.green,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5),
      child: Text("Bruce $item"),
    );
  }
}
