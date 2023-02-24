import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/authentication/signup/components/create_profile.dart';
import 'package:quickstep_app/screens/authentication/signup/components/verify_otp.dart';
import 'package:quickstep_app/screens/movements/widgets/app_bar_2.dart';

import '../../../utils/colors.dart';
import 'components/create_account.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late List<Widget> steps;
  int selectedIndex = 0;

  _init() {
    steps = [
      CreateAccount(
        onContinue: () {
          setState(() {
            selectedIndex = 1;
          });
        },
      ),
      VerifyOTP(onContinue: () {
        setState(() {
          selectedIndex = 2;
        });
      }, onPrev: () {
        setState(() {
          selectedIndex = 0;
        });
      }),
      CreateProfile(onStart: () {
        setState(() {
          selectedIndex = 0;
        });
      })
    ];
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: primary,
            elevation: 0.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            flexibleSpace: Hero(
              tag: "appbar-hero-custom-1",
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const AnotherCustomAppBar(
                  title: "Sign Up",
                ),
              ),
            ),
            toolbarHeight: 100,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: steps[selectedIndex],
            ),
          ),
        ),
      ),
    );
  }
}
