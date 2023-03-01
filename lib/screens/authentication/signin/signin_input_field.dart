import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';

class SignInInputField extends StatelessWidget {
  const SignInInputField({
    Key? key,
    required this.hintText,
    required this.svg,
    this.isPwd = false,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final String svg;
  final bool isPwd;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 13.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
          child: TextFormField(
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
            onChanged: onChanged,
            obscureText: isPwd,
            obscuringCharacter: "*",
            cursorColor: lightPrimary,
            decoration: InputDecoration(
              hintText: "Enter ${hintText.toLowerCase()}",
              isDense: true,
              contentPadding: EdgeInsets.all(8.r),
              hintStyle: TextStyle(
                color: grey400,
                fontWeight: FontWeight.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: lightPrimary,
                  width: 2,
                ),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SvgPicture.asset(
                  "assets/icons/$svg",
                  height: 34.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
