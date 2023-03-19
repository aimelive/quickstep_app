import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/screens/movements/map/movement_live_map.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class MovementTile extends StatelessWidget {
  const MovementTile({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(vertical: 18.h, horizontal: 2.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: lightPrimary.withOpacity(0.7),
            blurRadius: 10,
            // offset: Offset(5, dy)
          )
        ],
      ),
      child: Row(
        children: [
          Transform.scale(
            scaleY: 1.2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: lightPrimary,
              ),
              padding: EdgeInsets.all(4.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2019/05/29/15/09/maps-4237764_1280.jpg",
                  width: 120.w,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 6.r,
                right: 8.r,
                left: 8.r,
                top: 8.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movement.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "By ${movement.creator}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 15.sp,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              " Active",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.amberAccent.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        addHorizontalSpace(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group,
                              size: 15.sp,
                              color: primary,
                            ),
                            Text(
                              " ${movement.members}+",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: primary,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          pushPage(
                            context,
                            to: MovementLiveMap(
                              movement: movement,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                          padding: EdgeInsets.symmetric(
                            vertical: 2.5.h,
                            horizontal: 15.w,
                          ),
                        ),
                        label: Text(
                          movement.role == Role.viewer
                              ? "Watch movement"
                              : "Join movement",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
