import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/self_made_walk.dart';

import '../../../utils/colors.dart';

class SelfMadeWalksWidget extends StatelessWidget {
  const SelfMadeWalksWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      height: 190.h,
      child: ListView.builder(
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
                      "2 days ago",
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
                      walk.title,
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
                  ElevatedButton(
                    onPressed: () {},
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
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
