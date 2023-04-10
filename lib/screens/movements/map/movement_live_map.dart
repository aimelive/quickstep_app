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
    _socket.connect();
    // print(_socket.c);
    _socket.onConnect(
      (data) {
        //Joining the room movement
        _socket.emit("joinRoom", {
          "room": widget.movement.id,
          "user": account.userId,
          "username": account.username,
          "profileUrl": account.profilePic
        });

        //Listn to a connected message from backend
        _socket.on("connected", (message) {
          showMessage(message: message, title: widget.movement.title);
        });

        //Listen to current members active in the movement
        _socket.on("roomUsers", (data) {
          try {
            List<User> roomUsers = [];
            for (var userData in data["users"]) {
              roomUsers.add(User.fromJson(userData));
            }
            setState(() {
              members = roomUsers;
            });
            moveCnt.currentMoveMembers = members;
          } catch (e) {
            // print("Something went wrong while getting room users");
          }
        });

        //Listens to when someone changed location
        _socket.on("locationChanged", (data) async {
          try {
            final user = members.cast<User?>().firstWhere(
                  (member) => member?.id == data["user"],
                  orElse: () => null,
                );
            if (user == null ||
                data["lat"].runtimeType != double ||
                data["long"].runtimeType != double) return;

            final location = LatLng(data["lat"], data["long"]);

            await addMarker(user, location);

            if (moveCnt.currentMovingUserId.value != "" &&
                moveCnt.currentMovingUserId.value != user.id) {
              return;
            }

            if (user.id == account.userId && members.length > 1) {
              return;
            }

            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: zoomLevel,
                  target: location,
                ),
              ),
            );
          } catch (e) {
            // print(e);
          }
        });

        //Listens to when new chat message is received
        _socket.on("chatMessage", (data) async {
          try {
            final user = members.cast<User?>().firstWhere(
                  (member) => member?.id == data["userId"],
                  orElse: () => null,
                );
            if (user == null) return;
            final message = ChatMessage(
              user: user,
              message: data["message"],
              sentAt: DateTime.parse(data["sentAt"]),
              seen: members.length > 1,
            );
            if (user.id == account.userId) {
              if (members.length > 1) {
                moveCnt.markAsSeen(message);
              }
              return;
            }

            moveCnt.addMessage(message);
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
      (data) {},
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
        // mapController?.animateCamera(
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       zoom: zoomLevel,
        //       target: currentLocation!,
        //     ),
        //   ),
        // );
        // addMarker(
        //   User(
        //     id: account.userId,
        //     imgUrl: account.profilePic,
        //     username: "Me",
        //     caption: "My current location",
        //     location: currentLocation!,
        //   ),
        // );
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
    _socket.disconnect();
    _socket.destroy();
    _socket.dispose();
    moveCnt.onClose();
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
                  await addMarker(
                    User(
                      id: account.userId,
                      imgUrl: account.profilePic,
                      username: account.fullName,
                      joinedAt: DateTime.now(),
                    ),
                    currentLocation!,
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
            OverMapWidget(
              membersLength: widget.movement.members,
              cnt: moveCnt,
              onSendMessage: (message) {
                if (_socket.connected) {
                  _socket.emit("chatMessage", {
                    "userId": account.userId,
                    "message": message,
                  });
                }
              },
            ),
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

  addMarker(User user, LatLng location) async {
    var marker = await customMarker(
      MoveUser(
        user: user.id == account.userId
            ? User(
                id: user.id,
                imgUrl: user.imgUrl,
                username: "You",
                joinedAt: null,
              )
            : user,
        location: location,
      ),
    );
    if (!mounted) return;
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
