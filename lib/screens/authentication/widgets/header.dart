import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomClipPath2(),
          child: Container(
            color: lightPrimary,
            height: 300.h,
          ),
        ),
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            // alignment: Alignment.centerRight,
            color: primary,
            padding: EdgeInsets.only(top: 70.h, left: 25.w),
            width: double.infinity,
            height: 260.h,
            child: Text(
              "Quick step App",
              style: TextStyle(
                color: white,
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
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
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h / 3, w, h - (h / 4));
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
    path.quadraticBezierTo(w * 0.5, h / 2, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
