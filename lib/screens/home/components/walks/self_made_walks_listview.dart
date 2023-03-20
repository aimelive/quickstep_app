import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickstep_app/models/self_made_walk.dart';
import 'package:quickstep_app/screens/home/components/walks/map_self_made_walk.dart';
import 'package:quickstep_app/services/auth_service.dart';
import 'package:quickstep_app/utils/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../controllers/self_made_walks_controller.dart';
import '../../../../utils/colors.dart';
import '../../../movements/map/widgets/warn_dialog.dart';

class SelfMadeWalksWidget extends StatefulWidget {
  const SelfMadeWalksWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SelfMadeWalksWidget> createState() => _SelfMadeWalksWidgetState();
}

class _SelfMadeWalksWidgetState extends State<SelfMadeWalksWidget> {
  final walkController = Get.put(WalksController());
  final profile = AuthService().getAuth();

  void getWalks() {
    walkController.getWalks();
  }

  void _handleDelete(SelfMadeWalk walk) async {
    walkController.removeWalk(walk);
  }

  @override
  void initState() {
    getWalks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      walkController.currentState.value;
      final walks = walkController.walks;
      walks.sort((a, b) => b.endedAt.compareTo(a.endedAt));
      return Column(
        children: [
          Row(
            children: [
              Text(
                "Self-made Walks",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (walks.isNotEmpty)
                Text(
                  walks.length.toString(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              if (walks.isNotEmpty)
                Icon(
                  Icons.travel_explore,
                  size: 22.sp,
                  color: primary,
                )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.h),
            height: walks.isNotEmpty ? 190.h : null,
            child: walks.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          size: 30.sp,
                          color: primary,
                        ),
                        addVerticalSpace(20),
                        Text(
                          "No walks saved yet, Click start walking below",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: walks.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      final walk = walks[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              color: lightPrimary,
                            )
                          ],
                          borderRadius: BorderRadius.circular(8.r),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/map.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 190.w,
                        margin: EdgeInsets.only(right: 15.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.r,
                            horizontal: 15.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: veryLightGrey,
                                      blurRadius: 50,
                                      offset: Offset(-2, -2),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 1.5.h,
                                ),
                                child: Text(
                                  timeago.format(walk.createdAt),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CircleAvatar(
                                  radius: 32.r,
                                  foregroundImage: NetworkImage(
                                    profile!.profilePic,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  cfl(walk.title),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Map<String, LatLng> points =
                                          <String, LatLng>{
                                        "origin": walk.initialPosition,
                                        "destination": walk.destinationPosition,
                                      };
                                      pushPage(
                                        context,
                                        to: SelfMadeWalkMap(
                                          points: points,
                                          walk: walk,
                                          mode: SelfMadeWalkMapMode.idle,
                                          startedAt: DateTime.now(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 7.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                      ),
                                    ),
                                    child: const Text("View Travel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final leave = await showDialog<bool>(
                                        context: context,
                                        barrierColor: Colors.black26,
                                        builder: ((context) {
                                          return const WarnDialogWidget(
                                            title: "Delete Travel",
                                            subtitle:
                                                "Are you sure do you want to delete this travel?",
                                            okButtonText: "Delete",
                                          );
                                        }),
                                      );
                                      if (leave == true) {
                                        _handleDelete(walk);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 7.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      size: 22.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
          ),
        ],
      );
    });
  }
}
