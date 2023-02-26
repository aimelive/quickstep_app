import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class AnotherCustomAppBar extends StatelessWidget {
  const AnotherCustomAppBar({super.key, required this.title});

  final String title;

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
              padding: EdgeInsets.only(left: 20.w, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const BackButton(
                      color: white,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      style: TextStyle(
                        color: white,
                        fontSize: 20.sp,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 50, w, h - (h / 4));
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
