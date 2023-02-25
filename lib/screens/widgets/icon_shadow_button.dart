import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class IconShadowButton extends StatelessWidget {
  const IconShadowButton({
    Key? key,
    required this.onPress,
    required this.icon,
    this.removeShadow,
  }) : super(key: key);

  final VoidCallback onPress;
  final IconData icon;
  final bool? removeShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 5.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: removeShadow == true
                  ? Colors.grey.shade600
                  : Colors.grey.shade300,
              blurRadius: 12,
              offset: const Offset(5, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 28.sp,
          color: grey400,
        ),
      ),
    );
  }
}
