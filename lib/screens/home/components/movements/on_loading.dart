import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnLoadingStories extends StatelessWidget {
  const OnLoadingStories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: ((context, index) {
        return Container(
          width: 105.w,
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15.r),
          ),
        );
      }),
    );
  }
}