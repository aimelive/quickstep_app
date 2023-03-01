import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/authentication/signup/widgets/otp_number_widget.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/helpers.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({
    Key? key,
    required this.onContinue,
    required this.onPrev,
  }) : super(key: key);

  final VoidCallback onPrev;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 18.h,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "OTP (4 Digits)*".toUpperCase(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: primary.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        addVerticalSpace(18),
                        Text(
                          "We've sent an email to you with OTP, write down below to verify account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12.sp,
                          ),
                        ),
                        addVerticalSpace(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            OTPNumberBoxWidget(),
                            OTPNumberBoxWidget(),
                            OTPNumberBoxWidget(),
                            OTPNumberBoxWidget(),
                          ],
                        ),
                        addVerticalSpace(30),
                        Directionality(
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
                            label: const Text("VERIFY"),
                          ),
                        ),
                        addVerticalSpace(30),
                        Row(
                          children: const [
                            Expanded(child: Divider()),
                            Text("OR"),
                            Expanded(child: Divider()),
                          ],
                        ),
                        addVerticalSpace(30),
                        ElevatedButton.icon(
                          onPressed: onPrev,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text("GO BACK"),
                        ),
                      ],
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
