import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickstep_app/screens/authentication/signup/widgets/otp_number_widget.dart';
import 'package:quickstep_app/services/auth_service.dart';

import '../../../../controllers/auth.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/helpers.dart';
import '../../../components/top_snackbar.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final ct1 = TextEditingController();
  final ct2 = TextEditingController();
  final ct3 = TextEditingController();
  final ct4 = TextEditingController();

  final authService = AuthService();
  final authState = Get.find<AuthState>();

  bool isResending = false;
  bool isVerifying = false;

  @override
  Widget build(BuildContext context) {
    // print(authState.email);
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
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            onPressed: isVerifying
                                ? null
                                : () async {
                                    final str =
                                        "${ct1.text}${ct2.text}${ct3.text}${ct4.text}";
                                    if (int.tryParse(str) == null) return;
                                    int otp = int.parse(str);
                                    setState(() {
                                      isVerifying = true;
                                    });
                                    final result = await authService.verifyOTP(
                                      authState.email.value,
                                      otp,
                                    );
                                    if (!mounted) return;
                                    setState(() {
                                      isVerifying = false;
                                    });
                                    if (result == null) return;
                                    showMessage(
                                      message:
                                          "Account verified successfully, you can now sign in",
                                      title: "Account verified successfully",
                                      type: MessageType.success,
                                    );
                                    popPage(context);
                                  },
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: lightPrimary,
                              disabledForegroundColor: white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 8.h,
                              ),
                            ),
                            icon: isVerifying
                                ? LoadingAnimationWidget.inkDrop(
                                    color: white, size: 18.sp)
                                : Icon(
                                    Icons.arrow_back,
                                    size: 22.sp,
                                  ),
                            label: Text(
                              isVerifying ? "LOADING " : "VERIFY",
                              style: TextStyle(fontSize: 12.sp),
                            ),
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
                        Text(
                          "If you haven't received an email with OTP, click here to resend back to you",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12.sp,
                          ),
                        ),
                        addVerticalSpace(30),
                        ElevatedButton(
                          onPressed: isResending
                              ? null
                              : () async {
                                  setState(() {
                                    isResending = true;
                                  });
                                  final response = await authService
                                      .resendOTP(authState.email.value);
                                  setState(() {
                                    isResending = false;
                                  });
                                  if (response == null) return;
                                  showMessage(
                                    message:
                                        "OTP resent on ${authState.email.value}, check your email and enter the number sent to you in below fields",
                                    title: "Resend OTP",
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: lightPrimary,
                            disabledForegroundColor: white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              vertical: 8.h,
                            ),
                          ),
                          child: Text(
                            isResending ? "SENDING..." : "RESEND",
                            style: TextStyle(fontSize: 12.sp),
                          ),
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
