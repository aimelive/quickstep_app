import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: lightPrimary.withOpacity(0.7),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Positioned(
            top: -20,
            left: -20,
            child: CircleAvatar(
              radius: 25.sp,
              backgroundColor: primary,
              foregroundColor: white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 18.w,
              top: 12.h,
              right: 12.w,
              bottom: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "      2 min ago",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500,
                  ),
                ),
                addVerticalSpace(5),
                Text(
                  "Safaricom Tuesday Movement",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                addVerticalSpace(8),
                const Text(
                  "Safaricom company ltd has invited you to join the party of Afaricom",
                ),
                addVerticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 20.sp,
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                          backgroundColor: primary,
                          padding: EdgeInsets.symmetric(
                            vertical: 2.5.h,
                            horizontal: 15.w,
                          ),
                        ),
                        label: Text(
                          "Watch movement",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(
                          vertical: 2.5.h,
                          horizontal: 15.w,
                        ),
                      ),
                      child: Text(
                        "Decline",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
               
              },
              child: CircleAvatar(
                radius: 15.sp,
                backgroundColor: primary,
                foregroundColor: white,
                child: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
