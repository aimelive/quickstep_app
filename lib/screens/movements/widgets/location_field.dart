import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../../utils/colors.dart';

class ChooseLocationWidget extends StatelessWidget {
  const ChooseLocationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 11.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 2,
                color: grey400,
              ),
            ),
            child: Text(
              "Choose source location",
              maxLines: 1,
              style: TextStyle(
                color: Colors.grey.shade600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        addHorizontalSpace(8),
        InkWell(
          onTap: () {},
          highlightColor: primary.withOpacity(0.2),
          splashColor: white,
          borderRadius: BorderRadius.circular(10.r),
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 2,
                color: primary,
              ),
            ),
            child: Icon(
              Icons.map,
              color: primary,
              size: 22.sp,
            ),
          ),
        )
      ],
    );
  }
}
