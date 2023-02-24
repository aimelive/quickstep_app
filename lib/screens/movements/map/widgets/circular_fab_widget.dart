import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

const double buttonSize = 60;

class FabItem {
  String text;
  IconData icon;
  FabItem({
    required this.text,
    required this.icon,
  });
}

List<FabItem> fabItems = [
  FabItem(
    text: "Close",
    icon: Icons.power_settings_new_outlined,
  ),
  FabItem(
    text: "Leave",
    icon: Icons.fork_left,
  ),
  FabItem(
    text: "Take shot",
    icon: Icons.camera_alt_outlined,
  ),
  FabItem(
    text: "Invite",
    icon: Icons.share,
  ),
  FabItem(
    text: "Menu",
    icon: Icons.menu,
  ),
];

class CircularFabWidget extends StatefulWidget {
  const CircularFabWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CircularFabWidget> createState() => _CircularFabWidgetState();
}

class _CircularFabWidgetState extends State<CircularFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool showFab = false;
  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
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
