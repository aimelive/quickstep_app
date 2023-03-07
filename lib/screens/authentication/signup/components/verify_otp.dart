import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/authentication/signup/widgets/otp_number_widget.dart';
import 'package:quickstep_app/services/auth_service.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/helpers.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({
    Key? key,
    required this.onContinue,
    required this.onPrev,
  }) : super(key: key);

  final VoidCallback onPrev;
  final VoidCallback onContinue;

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final ct1 = TextEditingController();
  final ct2 = TextEditingController();
  final ct3 = TextEditingController();
  final ct4 = TextEditingController();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // print(widget.email);
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
                          children: [
                            OTPNumberBoxWidget(
                              controller: ct1,
                            ),
                            OTPNumberBoxWidget(
                              controller: ct2,
                            ),
                            OTPNumberBoxWidget(
                              controller: ct3,
                            ),
                            OTPNumberBoxWidget(
                              controller: ct4,
                            ),
                          ],
                        ),
                        addVerticalSpace(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // await authService.resendOTP(widget.email);
                                // showMessage(
                                //   message: "OTP resent on ${widget.email}",
                                //   title: "Resend OTP",
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 8.h,
                                ),
                              ),
                              // icon: const Icon(Icons.arrow_back),
                              child: const Text("RESEND"),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final str =
                                      "${ct1.text}${ct2.text}${ct3.text}${ct4.text}";
                                  if (int.tryParse(str) == null) return;
                                  int otp = int.parse(str);
                                  // final result = await authService.verifyOTP(
                                  //   widget.email,
                                  //   otp,
                                  // );
                                  // if (result.runtimeType != ErrorException) {
                                  //   widget.onContinue();
                                  // }
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
                          ],
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
                          onPressed: widget.onPrev,
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
