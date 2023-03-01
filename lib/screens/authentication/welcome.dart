import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/authentication/widgets/header.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../utils/colors.dart';
import 'signin/signin_dialog.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isSignDialogShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              const Header(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 30.h,
                ),
                child: Text(
                  "Join the best movements world has ever had around the community on map",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              addVerticalSpace(20),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isSignDialogShow = true;
                    });
                    customSignInDialog(context, isClosed: (_) {
                      setState(() {
                        isSignDialogShow = false;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 10.h,
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(
                    "GET STARTED ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copyright,
                      size: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                    Text(
                      " Aime Ndayambaje 2023",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(10)
            ],
          ),
        ),
      ),
    );
  }
}
