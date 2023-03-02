import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:quickstep_app/models/account.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/screens/components/warn_method.dart';
import 'package:quickstep_app/screens/movements/map/widgets/marker_custom.dart';
import 'package:quickstep_app/services/auth_service.dart';
// import 'package:image/image.dart' as image;

import '../../../models/user.dart';
import 'over_map_widget.dart';
import 'widgets/circular_fab_widget.dart';

class MovementLiveMap extends StatefulWidget {
  const MovementLiveMap({
    super.key,
    required this.movement,
  });

  final Movement movement;

  @override
  State<MovementLiveMap> createState() => _MovementLiveMapState();
}

class _MovementLiveMapState extends State<MovementLiveMap> {
  GoogleMapController? mapController;

  Map<String, Marker> markers = {};

  LatLng? currentLocation;
  double zoomLevel = 18;

  Account account = AuthService().getAuth()!;
  List<User> members = [];

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

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
    if (!mounted) return;
    setState(() {
      currentLocation = toCoor(locationData);
    });

    location.onLocationChanged.listen((newLoc) {
      if (!mounted) return;
      setState(() {
        currentLocation = toCoor(newLoc);
      });

      if (mapController != null) {
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: zoomLevel,
              target: currentLocation!,
            ),
          ),
        );
        addMarker(
          User(
            id: account.userId,
            imgUrl: account.profilePic,
            username: "Me",
            caption: "My current location",
            location: currentLocation!,
          ),
        );
      }
    });
  }

  getMembers() {
    members = dummyUsers;
    for (var user in members) {
      addMarker(user);
    }
  }

  @override
  void initState() {
    getMembers();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final leave = await warnMethod(
          context,
          title: "Leave movement",
          subtitle: "Are you sure do you want to leave this movement?",
          okButtonText: "Leave",
        );
        if (leave == true) return true;
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            if (currentLocation != null)
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentLocation!,
                  zoom: zoomLevel,
                ),
                compassEnabled: false,
                mapType: MapType.hybrid,
                onMapCreated: (controller) async {
                  mapController = controller;

                  addMarker(
                    User(
                      id: account.userId,
                      imgUrl: account.profilePic,
                      username: account.fullName,
                      caption: "My current location",
                      location: currentLocation!,
                    ),
                  );
                },
                myLocationButtonEnabled: false,
                markers: markers.values.toSet(),
                onCameraMove: (position) {
                  if (!mounted) return;
                  // setState(() {
                  //   zoomLevel = position.zoom;
                  // });
                },
              ),
            if (currentLocation == null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Loading current location..."),
                  ],
                ),
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
        floatingActionButton: mapController != null
            ? CircularFabWidget(gMapController: mapController!)
            : null,
      ),
    );
  }

  addMarker(User user) async {
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
    var marker = customMarker(user);
    setState(() {
      markers[user.id] = marker;
    });
  }

  LatLng toCoor(LocationData data) {
    return LatLng(
      data.latitude!,
      data.longitude!,
    );
  }
}
