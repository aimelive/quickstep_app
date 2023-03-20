import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/movement.dart';

import '../../../../utils/colors.dart';

class MovementStoryCard extends StatelessWidget {
  const MovementStoryCard({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //   begin: Alignment.topCenter,
        //   colors: [
        //     primary,
        //     Colors.orangeAccent,
        //     Colors.redAccent,
        //     lightPrimary
        //   ],
        // ),
        border: Border.all(
          color: lightPrimary,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.5.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 10.w,
            ),
            decoration: BoxDecoration(
              color: lightPrimary,
              image: const DecorationImage(
                image: AssetImage("assets/images/map.jpeg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.linearToSrgbGamma(),
              ),
              borderRadius: BorderRadius.circular(16.r),
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
                    "On going",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: white,
                    ),
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: primary,
                  foregroundColor: white,
                  child: Text(
                    movement.title[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  movement.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: white, fontSize: 14.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
