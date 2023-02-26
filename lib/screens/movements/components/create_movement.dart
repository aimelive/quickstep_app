import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import '../../../utils/helpers.dart';
import '../widgets/category.dart';
import '../widgets/location_field.dart';

class CreateMovement extends StatelessWidget {
  const CreateMovement({
    Key? key,
    required this.onContinue,
  }) : super(key: key);
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Create",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade900,
              ),
            ),
            addHorizontalSpace(5),
            Icon(
              Icons.add_circle_outline,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        Form(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 18.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Movement name*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                TextFormField(
                  style: const TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w600,
                  ),
                  cursorColor: lightPrimary,
                  decoration: InputDecoration(
                    hintText: "Enter a name",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 12.h,
                    ),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 2,
                        color: grey400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        width: 2,
                        color: lightPrimary,
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(18),
                Text(
                  "category*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                CategoryChoose(onSelected: () {}),
                addVerticalSpace(18),
                Text(
                  "choose source(optional)".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                const ChooseLocationWidget(),
                addVerticalSpace(18),
                Text(
                  "choose destination(optional)".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                const ChooseLocationWidget(),
                addVerticalSpace(18),
                Text(
                  "continue to invite members".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(18),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        onContinue();
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("CONTINUE"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
