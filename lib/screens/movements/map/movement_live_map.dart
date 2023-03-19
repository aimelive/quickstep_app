import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/models/account.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/screens/components/top_snackbar.dart';
import 'package:quickstep_app/screens/components/warn_method.dart';
import 'package:quickstep_app/screens/movements/map/widgets/marker_custom.dart';
import 'package:quickstep_app/services/auth_service.dart';
import 'package:quickstep_app/utils/keys.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
  final moveCnt = Get.find<MovementController>();
  GoogleMapController? mapController;

  Map<String, Marker> markers = {};

  LatLng? currentLocation;
  double zoomLevel = 18;

  Account account = AuthService().getAuth()!;
  List<User> members = [];

  //Sockets connections
  final io.Socket _socket = io.io(
    backendUrl.split('/api/v1')[0],
    io.OptionBuilder().setTransports(['websocket']).build(),
  );

  _connectSocket() {
    _socket.onConnect(
      (data) {
        //Joining the room movement
        _socket.emit("joinRoom", {
          "room": widget.movement.id,
          "user": account.userId,
          "username": account.username,
        });

        //Listn to a connected message from backend
        _socket.on("connected", (message) {
          showMessage(message: message, title: widget.movement.title);
        });

        //Listen to current members active in the movement
        _socket.on("roomUsers", (data) {
          try {
            // print(data["users"]);
          } catch (e) {
            // print("Something went wrong while getting room users");
          }
        });

        //Listens to when someone changed location
        _socket.on("locationChanged", (data) {
          try {
            addMarker(User.fromJson(data));
          } catch (e) {
            // print(e);
          }
        });
      },
    );

    // Listens when there is a connection error
    _socket.onConnectError(
      (data) {
        return showMessage(
          message:
              "Check your internet connection, if you found your internet not a problem, our server may temporarily down",
          title: "Connection Error",
          type: MessageType.error,
        );
      },
    );

    _socket.onDisconnect(
      (data) => null,
    );
  }

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
        if (_socket.connected) {
          //Emite location to the server
          _socket.emit("locationChanged", {
            "room": widget.movement.id,
            "user": account.userId,
            "lat": currentLocation!.latitude,
            "long": currentLocation!.longitude,
          });
        }
      }
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    _connectSocket();
    moveCnt.currentMovementId.value = widget.movement.id;
    super.initState();
  }

  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
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
                  setState(() {
                    zoomLevel = position.zoom;
                  });
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
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: mapController != null
            ? CircularFabWidget(
                gMapController: mapController!, id: widget.movement.id)
            : null,
      ),
    );
  }

  addMarker(User user) async {
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
