import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickstep_app/screens/authentication/signup/signup_page.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import 'signin_form.dart';

Future<Object?> customSignInDialog(BuildContext context,
    {required ValueChanged isClosed}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Sign in",
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: ((context, animation, secondaryAnimation, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    }),
    pageBuilder: ((context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          height: 620,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 34),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text("Get access to your account",
                          textAlign: TextAlign.center, style: TextStyle()),
                    ),
                    const SignInForm(),
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Sign up with Email, Apple or Google",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            popPage(context);
                            pushPage(context, to: const SignUpPage());
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/email_box.svg",
                            height: 64,
                            width: 64,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/google_box.svg",
                            height: 64,
                            width: 64,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/apple_box.svg",
                            height: 64,
                            width: 64,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -48,
                  child: Ink(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: lightPrimary.withOpacity(0.9),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => popPage(context),
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.white,
                        foregroundColor: primary,
                        child: Icon(
                          Icons.close,
                          size: 25.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }),
  ).then(isClosed);
}
