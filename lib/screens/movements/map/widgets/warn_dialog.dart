import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class WarnDialogWidget extends StatelessWidget {
  const WarnDialogWidget({
    Key? key,
    this.delete = false,
  }) : super(key: key);
  final bool delete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: primary,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              delete ? "Delete self-made walk?" : "Leave movement?",
              style: TextStyle(
                fontSize: 16.sp,
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
            addVerticalSpace(10),
            Text(
              delete
                  ? "Are you sure do you want to delete this walk?"
                  : "Are you sure do you want to leave this movement?",
              style: TextStyle(
                color: Colors.grey.shade100,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    popPage(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  child: const Text("Cancel"),
                ),
                addHorizontalSpace(10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                  ),
                  child: Text(delete ? "Delete" : "Leave"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
