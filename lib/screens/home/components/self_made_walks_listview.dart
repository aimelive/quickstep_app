import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickstep_app/models/self_made_walk.dart';
import 'package:quickstep_app/screens/home/components/map_self_made_walk.dart';
import 'package:quickstep_app/utils/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../services/hive_service.dart';
import '../../../utils/colors.dart';
import '../../movements/map/widgets/warn_dialog.dart';

class SelfMadeWalksWidget extends StatefulWidget {
  const SelfMadeWalksWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SelfMadeWalksWidget> createState() => _SelfMadeWalksWidgetState();
}

class _SelfMadeWalksWidgetState extends State<SelfMadeWalksWidget> {
  late HiveService _hiveService;
  List<SelfMadeWalk> walks = [];

  void getWalks() {
    final res = _hiveService.getAllWalks();
    setState(() {
      walks = res;
    });
  }

  void _handleDelete(int id) async {
    final res = await _hiveService.deleteWalk(id);
    if (res) {
      getWalks();
    }
  }

  @override
  void initState() {
    _hiveService = HiveService();
    getWalks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    color: lightPrimary,
                    borderRadius: BorderRadius.circular(8.r),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/map.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 200.w,
                  margin: EdgeInsets.only(right: 10.w),
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
                          child: Stack(
                            children: [
                              Positioned(
                                top: 22.h,
                                left: 110.w,
                                child: CircleAvatar(
                                  radius: 14.r,
                                  foregroundImage: const AssetImage(
                                    "assets/images/aime.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20.h,
                                left: 90.w,
                                child: CircleAvatar(
                                  radius: 16.r,
                                  foregroundImage: const AssetImage(
                                    "assets/images/aime.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 18.h,
                                left: 70.w,
                                child: CircleAvatar(
                                  radius: 20.r,
                                  foregroundImage: const AssetImage(
                                    "assets/images/aime.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 22.h,
                                right: 110.w,
                                child: CircleAvatar(
                                  radius: 14.r,
                                  foregroundImage: const AssetImage(
                                    "assets/images/aime.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20.h,
                                right: 90.w,
                                child: CircleAvatar(
                                  radius: 16.r,
                                  foregroundImage: const AssetImage(
                                    "assets/images/aime.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            "${walk.id} ${walk.title}",
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Map<String, LatLng> points = <String, LatLng>{
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
                                  borderRadius: BorderRadius.circular(25.r),
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
                                    return const WarnDialogWidget(delete:true);
                                  }),
                                );
                                if (leave == true) {
                                  _handleDelete(walk.id);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 7.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
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
    );
  }
}
