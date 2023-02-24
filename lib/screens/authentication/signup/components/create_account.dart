import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/helpers.dart';
import '../widgets/text_input_field.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({
    Key? key,
    required this.onContinue,
  }) : super(key: key);
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade900,
              ),
            ),
            addHorizontalSpace(5),
            Icon(
              Icons.add_circle_outline,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        Form(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 18.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Full name*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                const TextInputField(
                  hintText: "a name",
                ),
                addVerticalSpace(18),
                Text(
                  "Email*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                const TextInputField(
                  hintText: "an email",
                ),
                Text(
                  " Please note that you will be asked to verify this email",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.sp,
                  ),
                ),
                addVerticalSpace(18),
                Text(
                  "Password*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                const TextInputField(
                  hintText: "password",
                  obsecureText: true,
                ),
                addVerticalSpace(18),
                Text(
                  "Confirm password*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                const TextInputField(
                  hintText: "password again",
                  obsecureText: true,
                ),
                addVerticalSpace(30),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        onContinue();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 8.h,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("CREATE ACCOUNT"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
