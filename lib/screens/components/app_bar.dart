import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickstep_app/screens/notifications_page.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../utils/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomClipPath2(),
          child: Container(
            color: lightPrimary,
            height: 85.h,
          ),
        ),
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            alignment: Alignment.centerRight,
            color: primary,
            height: 85.h,
            child: Padding(
              padding: EdgeInsets.only(right: 20.w, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Quick Step",
                    style: TextStyle(
                      color: white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => pushPage(
                      context,
                      to: const NotificationsPage(),
                      asDialog: true,
                    ),
                    child: Badge(
                      badgeContent: Text(
                        "10",
                        style: TextStyle(color: white, fontSize: 10.sp),
                      ),
                      showBadge: true,
                      position: BadgePosition.topEnd(),
                      child: SvgPicture.asset(
                        'assets/icons/notification.svg',
                        height: 28.sp,
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    //path.moveTo(0, 100);
    path.lineTo(0, h - (h / 2));
    path.quadraticBezierTo(w * 0.5, h - 50, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomClipPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    //path.moveTo(0, 100);
    path.lineTo(0, h - ((h / 2) - 40));
    path.quadraticBezierTo(w * 0.5, h - 50, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
