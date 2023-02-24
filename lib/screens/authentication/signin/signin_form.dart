import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickstep_app/screens/layout.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            style: TextStyle(color: Colors.black54),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
            child: TextFormField(
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
              cursorColor: lightPrimary,
              decoration: InputDecoration(
                hintText: "Enter email",
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
                  child: SvgPicture.asset("assets/icons/email.svg"),
                ),
              ),
            ),
          ),
          const Text(
            "Password",
            style: TextStyle(color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              obscureText: true,
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
              cursorColor: lightPrimary,
              decoration: InputDecoration(
                hintText: "Enter password",
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset("assets/icons/pwd.svg"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            child: ElevatedButton.icon(
              onPressed: () {
                popPage(context);
                pushPage(context, to: const LayoutPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4c6ebb),
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
              icon: const Icon(
                CupertinoIcons.arrow_right,
                color: Color(0xFF9fcdf5),
              ),
              label: const Text("Sign In"),
            ),
          )
        ],
      ),
    );
  }
}
