import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/controllers/auth.dart';
import 'package:quickstep_app/screens/authentication/signin/signin_input_field.dart';

import '../../../utils/helpers.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
    Key? key,
  }) : super(key: key);
  final auth = Get.put(AuthState());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignInInputField(
            hintText: "Email",
            svg: "email.svg",
          ),
          const SignInInputField(
            hintText: "Password",
            svg: "pwd.svg",
            isPwd: true,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.h, bottom: 24.h),
            child: ElevatedButton.icon(
              onPressed: () {
                popPage(context);
                Future.delayed(
                  const Duration(milliseconds: 400),
                  () => auth.isSignedIn.value = true,
                );

                // pushPage(context, to: const LayoutPage());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
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
