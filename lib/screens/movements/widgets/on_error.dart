import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class OnError extends StatefulWidget {
  const OnError({super.key});

  @override
  State<OnError> createState() => _OnErrorState();
}

class _OnErrorState extends State<OnError> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          addVerticalSpace(50),
          Icon(
            Icons.running_with_errors_outlined,
            size: 40.sp,
            color: lightPrimary,
          ),
          addVerticalSpace(20),
          Text(
            "Sorry, we're currently facing an issues, try again later.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.sp),
          ),
          addVerticalSpace(20),
          ElevatedButton(
            onPressed: () {
              Get.find<MovementController>().getMovements();
            },
            child: const Text("Try again"),
          )
        ],
      ),
    );
  }
}
