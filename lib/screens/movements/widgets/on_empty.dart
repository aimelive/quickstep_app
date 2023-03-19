import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class OnEmpty extends StatelessWidget {
  const OnEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Column(
        children: [
          addVerticalSpace(30),
          Icon(
            Icons.location_on_outlined,
            size: 50.sp,
            color: lightPrimary,
          ),
          addVerticalSpace(20),
          Text(
            "Click on Create (+) button above to start a new movement.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
