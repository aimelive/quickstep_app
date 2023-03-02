import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickstep_app/auth_wrapper.dart';
import 'package:quickstep_app/services/hive_service.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  //Initializing flutter hive database
  await Hive.initFlutter();

  //Opening database of the saved walks
  await Future.wait([
    Hive.openBox(Boxes.selfMadeWalksBox),
    Hive.openBox(Boxes.activitiesBox),
    Hive.openBox(Boxes.authBox),
  ]);

  //Initialising dotenv variables
  await dotenv.load(fileName: "assets/dotenv/.env");

  //Running flutter application
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
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quick Step Application',
          color: primary,
          theme: MyThemes.theme,
          home: child,
        );
      },
      child: const AuthWrapper(),
    );
  }
}
