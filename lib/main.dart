import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/authentication/welcome.dart';
import 'package:quickstep_app/screens/layout.dart';
import 'package:quickstep_app/utils/theme.dart';

bool isSignedIn = true;

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Footstep App',
          theme: MyThemes.theme,
          home: child,
        );
      },
      child: isSignedIn ? const LayoutPage() : const WelcomeScreen(),
    );
  }
}
