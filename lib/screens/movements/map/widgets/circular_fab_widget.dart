import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/screens/components/warn_method.dart';
import 'package:quickstep_app/services/db_service.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

const double buttonSize = 60;

class FabItem {
  String text;
  IconData icon;
  VoidCallback onPress;

  FabItem({
    required this.text,
    required this.icon,
    required this.onPress,
  });
}

class CircularFabWidget extends StatefulWidget {
  const CircularFabWidget({
    Key? key,
    required this.gMapController,
    required this.id,
  }) : super(key: key);

  final GoogleMapController gMapController;
  final String id;

  @override
  State<CircularFabWidget> createState() => _CircularFabWidgetState();
}

class _CircularFabWidgetState extends State<CircularFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late List<FabItem> fabItems;

  final dbService = DBService();
  final _mvt = Get.find<MovementController>();

  _init() {
    fabItems = [
      FabItem(
        text: "Close",
        icon: Icons.power_settings_new_outlined,
        onPress: () async {
          final close = await warnMethod(
            context,
            title: "Close movement",
            subtitle: "Are you sure do you want to close this movement?",
            okButtonText: "Close",
          );
          if (close == null) return;
          final deleted = await dbService.deleteMovement(widget.id);
          if (deleted == true && mounted) {
            _mvt.removeMovement(widget.id);
            popPage(context);
          }
        },
      ),
      FabItem(
        text: "Leave",
        icon: Icons.fork_left,
        onPress: () async {
          final leave = await warnMethod(
            context,
            title: "Leave movement",
            subtitle: "Are you sure do you want to leave this movement?",
            okButtonText: "Leave",
          );
          if (leave == null || !mounted) return;
          popPage(context);
        },
      ),
      FabItem(
        text: "Take shot",
        icon: Icons.camera_alt_outlined,
        onPress: () async {
          final image = await widget.gMapController.takeSnapshot();
          if (image == null) return;
          showGeneralDialog<Map<String, LatLng>>(
            barrierLabel: "view-shot",
            context: context,
            barrierColor: Colors.black54,
            barrierDismissible: true,
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder:
                ((context, animation, secondaryAnimation, child) {
              final tween = Tween(
                begin: const Offset(-1, 0),
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
            pageBuilder: ((context, _, __) {
              return MapShotDialog(image: image);
            }),
          );
        },
      ),
      FabItem(
        text: "Invite",
        icon: Icons.share,
        onPress: () {},
      ),
      FabItem(
        text: "Menu",
        icon: Icons.menu,
        onPress: () {},
      ),
    ];
  }

  bool showFab = false;
  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(controller: controller),
      children: fabItems.map<Widget>(buildFAB).toList(),
    );
    // return FloatingActionButton(
    //   backgroundColor: primary,
    //   onPressed: () {},
    //   child: const Icon(
    //     Icons.share,
    //   ),
    // );
  }

  Widget buildFAB(FabItem item) {
    return SizedBox(
      // width: buttonSize,
      // height: buttonSize,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showFab = !showFab;
          });
          if (controller.status == AnimationStatus.completed) {
            controller.reverse();
          } else {
            controller.forward();
          }
          item.onPress();
        },
        child: (item.icon == Icons.menu)
            ? CircleAvatar(
                backgroundColor: primary,
                foregroundColor: white,
                radius: 25.5.r,
                child: Icon(
                  showFab ? Icons.close : Icons.map,
                  size: 25.sp,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: primary,
                    foregroundColor: white,
                    radius: 18.r,
                    child: Icon(
                      item.icon,
                      size: 18.sp,
                    ),
                  ),
                  addHorizontalSpace(5),
                  Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 15.w,
                    ),
                    // margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      item.text,
                      style: TextStyle(
                        color: white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // child: FloatingActionButton.extended(
      //   backgroundColor: primary.withOpacity(0.7),
      //   heroTag: icon.toString(),
      //   elevation: 0,
      //   label: Container(),
      //   icon: Icon(
      //     icon,
      //     color: Colors.white,
      //   ),
      //   onPressed: ,
      // ),
    );
  }
}

class MapShotDialog extends StatelessWidget {
  const MapShotDialog({
    Key? key,
    required this.image,
  }) : super(key: key);

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 400.h,
            width: double.infinity,
            child: Image.memory(
              image,
              fit: BoxFit.fitWidth,
              height: 400.h,
            ),
          ),
        ],
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    // final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;

    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      setValue(value) => isLastItem ? 0.0 : value;
      final radius = 120 * controller.value;
      final thetha = i * pi * 0.5 / (n - 2);
      final x = setValue(radius * cos(thetha));
      // final x = xStart - setValue(radius * cos(thetha));
      final y = yStart -
          setValue(radius * sin(thetha)) -
          //Comment below two lines if you have no captions
          (i == 3 ? 32 : 0) +
          (i == 1 ? 7 : 0);

      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(buttonSize / 2, buttonSize / 2)
          ..rotateZ(isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
          ..scale(isLastItem ? 1.0 : max(controller.value, 0.0))
          ..translate(-buttonSize / 2, -buttonSize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return false;
  }
}
