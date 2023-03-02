import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';

typedef OnSwitchChanged = void Function(bool value);

class SettingTile extends StatelessWidget {
  const SettingTile(
      {Key? key,
      required this.icon,
      required this.onSwitchChanged,
      required this.subText,
      required this.text,
      required this.active})
      : super(key: key);

  final IconData icon;
  final String text, subText;
  final OnSwitchChanged onSwitchChanged;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 25.h, 6.w, 18.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.w),
          Icon(
            icon,
            color: primary,
            size: 25.sp,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4.h),
                Text(
                  subText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF838383),
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeColor: primary.withOpacity(0.9),
              value: active,
              onChanged: onSwitchChanged,
            ),
          )
        ],
      ),
    );
  }
}
