import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/screens/movements/movement_live_map.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class MovementTile extends StatelessWidget {
  const MovementTile({
    Key? key,
    required this.movement,
  }) : super(key: key);
  final Movement movement;
  @override
  Widget build(BuildContext ctx) {
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
                child: Image.asset(
                  "assets/images/${movement.imgUrl}",
                  width: 120.w,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 15.sp,
                              color: Colors.green.shade400,
                            ),
                            Text(
                              " ${movement.km}km",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.green.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group,
                              size: 15.sp,
                              color: primary,
                            ),
                            Text(
                              " 15+",
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
                        onPressed: () => pushPage(
                          ctx,
                          to: const MovementLiveMap(),
                        ),
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
